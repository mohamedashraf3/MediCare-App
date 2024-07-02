import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String message;
  int userId;
  int receiverId;
  String senderName;
  String receiverName;
  DateTime timestamp;
  String? conversationId;
  String? lastMessage;

  ChatModel({
    required this.message,
    required this.userId,
    required this.receiverId,
    required this.senderName,
    required this.receiverName,
    required this.timestamp,
    this.conversationId,
    this.lastMessage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      message: json['message'] ?? 'No message',
      userId: json['userId'] ?? 0,
      receiverId: json['receiverId'] ?? 0,
      senderName: json['senderName'] ?? 'No senderName',
      receiverName: json['receiverName'] ?? 'No receiverName',
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      conversationId: json['conversationId'],
      lastMessage: json['lastMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'userId': userId,
      'receiverId': receiverId,
      'senderName': senderName,
      'receiverName': receiverName,
      'timestamp': timestamp,
      'conversationId': conversationId,
      'lastMessage': lastMessage,
    };
  }
}
