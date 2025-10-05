part of 'chat_messages_bloc.dart';

abstract class ChatMessagesEvent {}

class LoadChatMessages extends ChatMessagesEvent {
  final int chatId;
  LoadChatMessages(this.chatId);
}

class SendChatMessage extends ChatMessagesEvent {
  final int chatId;
  final String content;
  SendChatMessage(this.chatId, this.content);
}
