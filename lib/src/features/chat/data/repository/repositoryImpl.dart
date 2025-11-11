import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:jihc_landf/src/core/datasources.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../domain/entities/chat_entities.dart';
import '../../domain/repositry/repository.dart';
import '../models/chat_models.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class ChatRepositoryImpl implements ChatRepository {
  final Dio _dio;
  ChatRepositoryImpl(ApiClient client)
    : _dio = client.dio..options.headers = {'Content-Type': 'application/json'};

  WebSocketChannel? _channel;
  final _controller = StreamController<MessageDto>.broadcast();
  @override
  Stream<MessageDto> get messageStream => _controller.stream;
  @override
  Future<List<ChatEntity>> getChats(int userId) async {
    final res = await _dio.get('/chats/$userId/');
    final data = (res.data as List).cast<Map<String, dynamic>>();
    return data.map((e) => ChatDto.fromJson(e).toEntity()).toList();
  }

  @override
  Future<List<MessageEntity>> getMessages(int chatId) async {
    final res = await _dio.get('/chats/$chatId/messages/');
    final data = (res.data as List).cast<Map<String, dynamic>>();
    return data.map((e) => MessageDto.fromJson(e).toEntity()).toList();
  }

  @override
  WebSocketChannel connectWebSocket(int chatId) {
    final uri = Uri.parse('ws://127.0.0.1:8000/chats/ws/$chatId');
    return IOWebSocketChannel.connect(uri);
  }
  @override
  Future<void> sendMessage(MessagePost message) async {
    try {
      if (_channel == null) {
        throw Exception("WebSocket channel not connected");
      }

      final jsonString = jsonEncode(message.toJson());
      _channel!.sink.add(jsonString);

      // Optionally, wait a tick to mimic async behavior
      await Future.delayed(Duration(milliseconds: 10));
    } catch (e) {
      throw Exception("Failed to send message: $e");
    }
  }

  @override
  Future<void> disconnect() async {
    await _channel?.sink.close();
    await _controller.close();
  }

  @override
  @override
  Future<ChatEntity> createChat(
    int userA,
    int userB,
    String? userNameA,
    String? userNameB,
    String? item,
    String? itemImage,
    String? itemId,
    String? createdAt,
  ) async {
    final res = await _dio.post(
      '/chats/',
      data: {
        "id": 0,
        "user_ids": [userA, userB],
        "user_names": [userNameA, userNameB],
        "item": item,
        "last_message": "string",
        "item_image": itemImage,
        "item_id": itemId,
        "created_at": createdAt,
      },
    );
    return ChatDto.fromJson(res.data as Map<String, dynamic>).toEntity();
  }

  @override
  Future<String> deleteChat(String chatId) async {
    final res = await _dio.delete('/chats/$chatId/');
    if (res.statusCode != 204) {
      throw Exception('Failed to delete message');
    } else {
      return 'Message deleted successfully';
    }
  }
}
