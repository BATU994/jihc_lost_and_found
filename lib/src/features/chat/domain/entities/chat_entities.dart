import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final int id;
  final List<int> userIds;
  final List<String> userNames;
  final String? item;
  final String? itemImage;
  final String? itemId;
  const ChatEntity({
    required this.id,
    required this.userIds,
    required this.userNames,
    this.item,
    this.itemImage,
    this.itemId,
  });

  @override
  List<Object?> get props => [id, userIds, userNames, item, itemImage, itemId];
}

class MessageEntity extends Equatable {
  final int id;
  final int senderId;
  final int receiverId;
  final String content;
  final DateTime timestamp;
  const MessageEntity({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, senderId, receiverId, content, timestamp];
}
