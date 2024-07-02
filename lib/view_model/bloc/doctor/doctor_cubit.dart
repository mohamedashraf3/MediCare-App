import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare/model/doctor_model.dart';
import '../../../model/chat_model.dart';
import '../../data/network/dio_helper.dart';
import '../../data/network/end_points.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(ChatInitial());

  static DoctorCubit get(context) => BlocProvider.of<DoctorCubit>(context);

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CollectionReference messages = FirebaseFirestore.instance.collection('Messages');
  CollectionReference conversations = FirebaseFirestore.instance.collection('Conversations');

  final controller = ScrollController();

  Stream<List<ChatModel>>? messageStream;

  void fetchMessages(int senderId, int receiverId) {
    print("senderId: $senderId, receiverId: $receiverId");
    messageStream = messages
        .orderBy('timestamp', descending: true)
        .where('userId', whereIn: [senderId, receiverId])
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatModel.fromJson(doc.data() as Map<String, dynamic>);
      }).where((message) {
        return (message.userId == senderId && message.receiverId == receiverId) ||
            (message.userId == receiverId && message.receiverId == senderId);
      }).toList();
    });
    emit(FetchMessagesSuccessState());
  }

  Future<void> sendMessage({
    required String message,
    required int senderId,
    required int receiverId,
    required String senderName,
    required String receiverName,
  }) async {
    DateTime now = DateTime.now();
    try {
      // Add message to the Messages collection
      DocumentReference docRef = await messages.add({
        'message': message,
        'userId': senderId,
        'receiverId': receiverId,
        'senderName': senderName,
        'receiverName': receiverName,
        'timestamp': now,
      });

      // Update or create a conversation in the Conversations collection
      String conversationId = '$senderId\_$receiverId';
      await conversations.doc(conversationId).set({
        'userId': senderId,
        'receiverId': receiverId,
        'senderName': senderName,
        'receiverName': receiverName,
        'lastMessage': message,
        'timestamp': now,
      }, SetOptions(merge: true));

      print("Message sent successfully");
      emit(SendMessageSuccessState());
      moveController();
    } catch (error) {
      print("Failed to send message: $error");
      emit(SendMessageErrorState());
    }
  }

  Future<List<ChatModel>> fetchConversations(int userId) async {
    emit(FetchConversationsLoading());
    try {
      QuerySnapshot snapshot = await conversations.where('userId', isEqualTo: userId).get();

      if (snapshot.docs.isEmpty) {
        print("No conversations found for userId: $userId");
        emit(FetchConversationsSuccess());
        return [];
      }

      List<ChatModel> chatList = snapshot.docs
          .map((doc) => ChatModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      // Sort chatList based on timestamp of the last message
      chatList.sort((a, b) => b.timestamp.compareTo(a.timestamp!));

      emit(FetchConversationsSuccess());
      return chatList;
    } catch (e) {
      print("Error fetching conversations: $e");
      emit(FetchConversationsError());
      throw e;
    }
  }

  Future<void> moveController() async {
    controller.animateTo(
      0,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    emit(MoveControllerSuccess());
  }

  bool isChatSelectionMode = false;
  List<ChatModel> selectedChats = [];

  void selectChat(ChatModel chat) {
    if (selectedChats.contains(chat)) {
      selectedChats.remove(chat);
    } else {
      selectedChats.add(chat);
    }
    isChatSelectionMode = selectedChats.isNotEmpty;
    emit(SelectChatState());
  }

  Future<void> deleteSelectedChats(List<String> conversationIds) async {
    emit(DeleteSelectedChatsLoading());
    try {
      for (String conversationId in conversationIds) {
        print("Attempting to delete conversation: $conversationId");
        await conversations.doc(conversationId).delete();
        print("Deleted conversation: $conversationId");
      }
      selectedChats.clear();
      isChatSelectionMode = false;
      emit(DeleteSelectedChatsSuccess());
    } catch (error) {
      print("Error deleting conversations: $error");
      if (error is FirebaseException) {
        print("Error code: ${error.code}");
        print("Error message: ${error.message}");
      }
      emit(DeleteSelectedChatsError());
    }
  }

  bool isChatSelected(ChatModel chat) {
    return selectedChats.contains(chat);
  }

  DoctorListModel? doctorListModel;
  List<DoctorModel> doctorList = [];

  Future<void> getDoctors() async {
    emit(GetDoctorLoadingState());
    await DioHelper.get(
      endpoint: EndPoints.Doctor,
    ).then((value) {
      print(value?.data);
      doctorListModel = DoctorListModel.fromJson(value?.data);
      doctorList = doctorListModel?.doctors ?? [];
      emit(GetDoctorSuccessState());
    }).catchError((error) {
      if (error is DioException) {
        print(error.response?.data.toString());
        emit(GetDoctorErrorState());
      }
    });
  }
}
