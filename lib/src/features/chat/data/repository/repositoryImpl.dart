import 'package:jihc_landf/src/core/datasources.dart';
import '../../domain/entities/chat_entities.dart';
import '../../domain/repositry/repository.dart';
import '../models/chat_models.dart';
import 'package:dio/dio.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(ApiClient client)
    : _dio = client.dio..options.headers = {'Content-Type': 'application/json'};

  final Dio _dio;

  @override
  Future<List<ChatEntity>> getChats(int userId) async {
    final res = await _dio.get('/chats/user/$userId');
    final data = (res.data as List).cast<Map<String, dynamic>>();
    return data.map((e) => ChatDto.fromJson(e).toEntity()).toList();
  }

  @override
  Future<List<MessageEntity>> getMessages(int chatId) async {
    final res = await _dio.get('/chats/$chatId/messages');
    final data = (res.data as List).cast<Map<String, dynamic>>();
    return data.map((e) => MessageDto.fromJson(e).toEntity()).toList();
  }

  @override
  Future<MessageEntity> sendMessage(int chatId, String content) async {
    final res = await _dio.post(
      '/chats/$chatId/messages',
      data: {"content": content},
    );
    return MessageDto.fromJson(res.data as Map<String, dynamic>).toEntity();
  }

  @override
  Future<ChatEntity> createChat(int userA, int userB) async {
    final res = await _dio.post(
      '/chats',
      data: {
        "user_ids": [userA, userB],
      },
    );
    return ChatDto.fromJson(res.data as Map<String, dynamic>).toEntity();
  }
}
