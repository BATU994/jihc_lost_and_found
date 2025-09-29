import '../../domain/entities/chat_entities.dart';

class ChatDto {
  final int id;
  final List<int> userIds;
  ChatDto({required this.id, required this.userIds});
  factory ChatDto.fromJson(Map<String, dynamic> json) => ChatDto(
        id: json['id'] as int,
        userIds: (json['user_ids'] as List).map((e) => e as int).toList(),
      );
  ChatEntity toEntity() => ChatEntity(id: id, userIds: userIds);
}

class MessageDto {
  final int id;
  final int senderId;
  final int receiverId;
  final String content;
  final DateTime timestamp;
  MessageDto({required this.id, required this.senderId, required this.receiverId, required this.content, required this.timestamp});
  factory MessageDto.fromJson(Map<String, dynamic> json) => MessageDto(
        id: json['id'] as int,
        senderId: json['sender_id'] as int,
        receiverId: json['receiver_id'] as int,
        content: json['content'] as String,
        timestamp: DateTime.parse(json['timestamp'] as String),
      );
  MessageEntity toEntity() => MessageEntity(id: id, senderId: senderId, receiverId: receiverId, content: content, timestamp: timestamp);
}

