import '../../domain/entities/chat_entities.dart';

class ChatDto {
  final int id;
  final List<int> userIds;
  final List<String> userNames;
  final String? item;
  final String? itemImage;
  ChatDto({
    required this.id,
    required this.userIds,
    required this.userNames,
    this.item,
    this.itemImage,
  });
  factory ChatDto.fromJson(Map<String, dynamic> json) => ChatDto(
    id: json['id'] as int,
    userIds: (json['user_ids'] as List).map((e) => e as int).toList(),
    userNames: (json['user_names'] as List).map((e) => e as String).toList(),
    item: json['item'] as String?,
    itemImage: json['item_image'] as String?,
  );
  ChatEntity toEntity() => ChatEntity(
    id: id,
    userIds: userIds,
    userNames: userNames,
    item: item,
    itemImage: itemImage,
  );
}

class MessageDto {
  final int id;
  final int senderId;
  final int receiverId;
  final String content;
  final DateTime timestamp;
  MessageDto({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
  });
  factory MessageDto.fromJson(Map<String, dynamic> json) => MessageDto(
    id: json['id'] as int,
    senderId: json['sender_id'] as int,
    receiverId: json['receiver_id'] as int,
    content: json['content'] as String,
    timestamp: DateTime.parse(json['timestamp'] as String),
  );
  MessageEntity toEntity() => MessageEntity(
    id: id,
    senderId: senderId,
    receiverId: receiverId,
    content: content,
    timestamp: timestamp,
  );
}
