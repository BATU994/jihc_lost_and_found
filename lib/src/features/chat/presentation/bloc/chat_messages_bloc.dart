import 'package:bloc/bloc.dart';
import '../../domain/entities/chat_entities.dart';
import '../../domain/repositry/repository.dart';

part 'chat_messages_event.dart';
part 'chat_messages_state_bloc.dart';

class ChatMessagesBloc extends Bloc<ChatMessagesEvent, ChatMessagesStateBloc> {
  final ChatRepository repo;
  ChatMessagesBloc(this.repo) : super(ChatMessagesInitial()) {
    on<LoadChatMessages>((event, emit) async {
      emit(ChatMessagesLoading());
      try {
        final msgs = await repo.getMessages(event.chatId);
        emit(ChatMessagesLoaded(msgs));
      } catch (e) {
        emit(ChatMessagesError(e.toString()));
      }
    });

    on<SendChatMessage>((event, emit) async {
      try {
        final m = await repo.sendMessage(event.chatId, event.content);
        if (state is ChatMessagesLoaded) {
          final current = List<MessageEntity>.from(
            (state as ChatMessagesLoaded).messages,
          )..add(m);
          emit(ChatMessagesLoaded(current));
        }
      } catch (e) {
        emit(ChatMessagesError(e.toString()));
      }
    });
  }
}
