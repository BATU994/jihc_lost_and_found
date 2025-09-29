part of 'chat_messages_cubit.dart';

class ChatMessagesState extends Equatable {
  final bool loading;
  final List<MessageEntity> messages;
  final String? error;

  const ChatMessagesState({required this.loading, required this.messages, this.error});

  factory ChatMessagesState.initial() => const ChatMessagesState(loading: false, messages: []);

  ChatMessagesState copyWith({bool? loading, List<MessageEntity>? messages, String? error}) =>
      ChatMessagesState(loading: loading ?? this.loading, messages: messages ?? this.messages, error: error);

  @override
  List<Object?> get props => [loading, messages, error];
}

