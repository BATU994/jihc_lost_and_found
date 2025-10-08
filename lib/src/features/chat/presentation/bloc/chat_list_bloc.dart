import 'package:bloc/bloc.dart';
import '../../domain/entities/chat_entities.dart';
import '../../domain/repositry/repository.dart';

part 'chat_list_event.dart';
part 'chat_list_state_bloc.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListStateBloc> {
  final ChatRepository repo;

  ChatListBloc(this.repo) : super(ChatListInitial()) {
    on<LoadChats>((event, emit) async {
      emit(ChatListLoading());
      try {
        final chats = await repo.getChats(event.userId);
        emit(ChatListLoaded(chats));
      } catch (e) {
        emit(ChatListError(e.toString()));
      }
    });

    on<RefreshChats>((event, emit) async {
      try {
        final chats = await repo.getChats(event.userId);
        emit(ChatListLoaded(chats));
      } catch (e) {
        emit(ChatListError(e.toString()));
      }
    });

    on<DeleteChat>((event, emit) async {
      emit(ChatDeleting());
      try {
        await repo.deleteChat(event.chatId);
        emit(ChatDeleted("Chat deleted successfully"));
      } catch (e) {
        emit(ChatListError(e.toString()));
      }
    });
  }
}
