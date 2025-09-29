import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_entities.dart';
import '../../domain/repositry/repository.dart';

part 'chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListState> {
  ChatListCubit(this.repo) : super(ChatListState.initial());

  final ChatRepository repo;

  Future<void> load(int userId) async {
    emit(state.copyWith(loading: true));
    try {
      final chats = await repo.getChats(userId);
      emit(state.copyWith(loading: false, chats: chats));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}

