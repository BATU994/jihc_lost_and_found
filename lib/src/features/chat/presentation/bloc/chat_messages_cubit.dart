import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_entities.dart';
import '../../domain/repositry/repository.dart';

part 'chat_messages_state.dart';

class ChatMessagesCubit extends Cubit<ChatMessagesState> {
  ChatMessagesCubit(this.repo) : super(ChatMessagesState.initial());

  final ChatRepository repo;

  Future<void> load(int chatId) async {
    emit(state.copyWith(loading: true));
    try {
      final msgs = await repo.getMessages(chatId);
      emit(state.copyWith(loading: false, messages: msgs));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> send(int chatId, String content) async {
    try {
      final m = await repo.sendMessage(chatId, content);
      final updated = List<MessageEntity>.from(state.messages)..add(m);
      emit(state.copyWith(messages: updated));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}

