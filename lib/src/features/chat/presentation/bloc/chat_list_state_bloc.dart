part of 'chat_list_bloc.dart';

abstract class ChatListStateBloc {}

class ChatListInitial extends ChatListStateBloc {}

class ChatListLoading extends ChatListStateBloc {}

class ChatListLoaded extends ChatListStateBloc {
  final List<ChatEntity> chats;
  ChatListLoaded(this.chats);
}

class ChatListError extends ChatListStateBloc {
  final String message;
  ChatListError(this.message);
}

class ChatDeleting extends ChatListStateBloc {}

class ChatDeleted extends ChatListStateBloc {
  final String message;
  ChatDeleted(this.message);
}
