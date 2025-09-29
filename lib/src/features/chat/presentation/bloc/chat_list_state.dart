part of 'chat_list_cubit.dart';

class ChatListState extends Equatable {
  final bool loading;
  final List<ChatEntity> chats;
  final String? error;

  const ChatListState({required this.loading, required this.chats, this.error});

  factory ChatListState.initial() => const ChatListState(loading: false, chats: []);

  ChatListState copyWith({bool? loading, List<ChatEntity>? chats, String? error}) =>
      ChatListState(loading: loading ?? this.loading, chats: chats ?? this.chats, error: error);

  @override
  List<Object?> get props => [loading, chats, error];
}

