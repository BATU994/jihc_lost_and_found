import '../entities/chat_entities.dart';

abstract class ChatRepository {
  Future<List<ChatEntity>> getChats(int userId);
  Future<List<MessageEntity>> getMessages(int chatId);
  Future<MessageEntity> sendMessage(int chatId, String content);
  Future<ChatEntity> createChat(
    int userA,
    int userB,
    String? userNameA,
    String? userNameB,
    String? item,
    String? itemImage,
    String? itemId,
  );
}
