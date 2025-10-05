part of 'chat_list_bloc.dart';

abstract class ChatListEvent {}

class LoadChats extends ChatListEvent {
  final int userId;
  LoadChats(this.userId);
}

class RefreshChats extends ChatListEvent {
  final int userId;
  RefreshChats(this.userId);
}

class DeleteChat extends ChatListEvent {
  final String chatId;
  DeleteChat(this.chatId);
}