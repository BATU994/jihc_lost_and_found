import 'package:dartz/dartz.dart';
import 'package:jihc_landf/src/features/chat/data/models/chat_models.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../entities/chat_entities.dart';

abstract class ChatRepository {
  Future<List<ChatEntity>> getChats(int userId);
  Future<List<MessageEntity>> getMessages(int chatId);
  Future<void> sendMessage(MessagePost message);
  Future<String> deleteChat(String message);
  Future<void> disconnect();
  WebSocketChannel connectWebSocket(int chatId);
  Future<ChatEntity> createChat(
    int userA,
    int userB,
    String? userNameA,
    String? userNameB,
    String? item,
    String? itemImage,
    String? itemId,
    String? createdAt,
  );
}
