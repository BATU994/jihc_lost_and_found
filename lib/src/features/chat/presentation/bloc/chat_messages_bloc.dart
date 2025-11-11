import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:jihc_landf/src/features/chat/data/models/chat_models.dart';
import '../../domain/entities/chat_entities.dart';
import '../../domain/repositry/repository.dart';

part 'chat_messages_event.dart';
part 'chat_messages_state_bloc.dart';

class ChatMessagesBloc extends Bloc<ChatMessagesEvent, ChatMessagesStateBloc> {
  final ChatRepository repo;
  WebSocketChannel? _channel;
  StreamSubscription? _socketSub;

  ChatMessagesBloc(this.repo) : super(ChatMessagesInitial()) {
    // Load chat messages from API
    on<LoadChatMessages>((event, emit) async {
      emit(ChatMessagesLoading());
      try {
        final msgs = await repo.getMessages(event.chatId);
        emit(ChatMessagesLoaded(msgs));
      } catch (e) {
        emit(ChatMessagesError(e.toString()));
      }
    });

    // Connect to WebSocket
    on<ConnectToChat>((event, emit) async {
      try {
        _channel = repo.connectWebSocket(event.chatId);
        _socketSub = _channel!.stream.listen((data) {
          final jsonData = jsonDecode(data);
          final message = MessageDto.fromJson(jsonData).toEntity();

          if (state is ChatMessagesLoaded) {
            final updated = List<MessageEntity>.from(
              (state as ChatMessagesLoaded).messages,
            )..add(message);
            emit(ChatMessagesLoaded(updated));
          }
        });
      } catch (e) {
        emit(ChatMessagesError('WebSocket connection failed: $e'));
      }
    });

    on<SendChatMessage>((event, emit) async {
      try {
        final message = MessagePost(
          senderId: event.senderId,
          receiverId: event.receiverId,
          content: event.content,
        );
        if (_channel != null) {
          print(message.toJson());
          print(jsonEncode(message.toJson()));
          _channel!.sink.add(message.toJson());
        }
      } catch (e) {
        emit(ChatMessagesError(e.toString()));
      }
    });

    on<DisconnectChat>((event, emit) async {
      await _socketSub?.cancel();
      await _channel?.sink.close();
      _channel = null;
    });
  }

  @override
  Future<void> close() {
    _socketSub?.cancel();
    _channel?.sink.close();
    return super.close();
  }
}
