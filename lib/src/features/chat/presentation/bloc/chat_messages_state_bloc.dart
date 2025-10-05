part of 'chat_messages_bloc.dart';

abstract class ChatMessagesStateBloc {}

class ChatMessagesInitial extends ChatMessagesStateBloc {}

class ChatMessagesLoading extends ChatMessagesStateBloc {}

class ChatMessagesLoaded extends ChatMessagesStateBloc {
  final List<MessageEntity> messages;
  ChatMessagesLoaded(this.messages);
}

class ChatMessagesError extends ChatMessagesStateBloc {
  final String message;
  ChatMessagesError(this.message);
}
