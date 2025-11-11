import '../../domain/entities/chat_entities.dart';

class ChatDto {
  final int id;
  final List<int> userIds;
  final List<String> userNames;
  final String? item;
  final String? itemImage;
  final String itemId;
  ChatDto({
    required this.id,
    required this.itemId,
    required this.userIds,
    required this.userNames,
    this.item,
    this.itemImage,
  });
  factory ChatDto.fromJson(Map<String, dynamic> json) => ChatDto(
    itemId: json['item_id'] as String,
    id: json['id'] as int,
    userIds: (json['user_ids'] as List).map((e) => e as int).toList(),
    userNames: (json['user_names'] as List).map((e) => e as String).toList(),
    item: json['item'] as String?,
    itemImage: json['item_image'] as String?,
  );
  ChatEntity toEntity() => ChatEntity(
    itemId: itemId,
    id: id,
    userIds: userIds,
    userNames: userNames,
    item: item,
    itemImage: itemImage,
  );
}

class MessageDto {
  final int senderId;
  final int receiverId;
  final String content;
  final DateTime timestamp;
  MessageDto({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
  });
  factory MessageDto.fromJson(Map<String, dynamic> json) => MessageDto(
    senderId: json['sender_id'] as int,
    receiverId: json['receiver_id'] as int,
    content: json['content'] as String,
    timestamp: DateTime.parse(json['timestamp'] as String),
  );
  MessageEntity toEntity() => MessageEntity(  
    senderId: senderId,
    receiverId: receiverId,
    content: content,
    timestamp: timestamp,
  );
}

class MessagePost {
  final int senderId;
  final int receiverId;
  final String content;
  MessagePost({ 
    required this.senderId,
    required this.receiverId,
    required this.content,
  });
  factory MessagePost.fromJson(Map<String, dynamic> json) => MessagePost(
    senderId: json['sender_id'] as int,
    receiverId: json['receiver_id'] as int,
    content: json['content'] as String,
  );
  Map<String, dynamic> toJson() {
    return {'sender_id': senderId, 'receiver_id': receiverId, 'content': content};
  }
}
