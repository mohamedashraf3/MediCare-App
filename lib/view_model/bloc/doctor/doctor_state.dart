part of 'doctor_cubit.dart';

abstract class DoctorState {}

final class ChatInitial extends DoctorState {}

final class SendMessageSuccessState extends DoctorState {}

final class SendMessageErrorState extends DoctorState {}

final class GetChatSuccessState extends DoctorState {}
final class FetchConversationsLoading extends DoctorState {}
final class FetchConversationsSuccess extends DoctorState {}
  final class FetchMessagesSuccessState extends DoctorState {}
final class FetchConversationsError extends DoctorState {}
final class DeleteSelectedChatsLoading extends DoctorState {}
final class DeleteSelectedChatsSuccess extends DoctorState {}
final class DeleteSelectedChatsError extends DoctorState {}

final class MoveControllerSuccess extends DoctorState {}


final class SelectChatState extends DoctorState {}
final class ClearSelectionState extends DoctorState {}
final class deleteSelectedChatsState extends DoctorState {}
final class GetDoctorLoadingState extends DoctorState {}
final class GetDoctorSuccessState extends DoctorState {}
final class GetDoctorErrorState extends DoctorState {}


