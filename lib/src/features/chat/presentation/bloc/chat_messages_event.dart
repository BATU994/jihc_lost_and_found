part of 'chat_messages_bloc.dart';

abstract class ChatMessagesEvent {}

class LoadChatMessages extends ChatMessagesEvent {
  final int chatId;
  LoadChatMessages(this.chatId);
}

class ConnectToChat extends ChatMessagesEvent {
  final int chatId;
  ConnectToChat(this.chatId);
}

class SendChatMessage extends ChatMessagesEvent {
  final int senderId;
  final int receiverId;
  final String content;
  SendChatMessage({
    required this.senderId,
    required this.receiverId,
    required this.content,
  });
}

class DisconnectChat extends ChatMessagesEvent {}
