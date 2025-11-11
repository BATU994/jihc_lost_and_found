part of 'item_bloc.dart';

@immutable
abstract class ItemEvent {}

class FetchItems extends ItemEvent {}

class PostItemRequested extends ItemEvent {
  final ItemEntityPost item;
  PostItemRequested({required this.item});
}

class FetchUserItems extends ItemEvent {
  final int userId;
  FetchUserItems(this.userId);
}

class DeleteItem extends ItemEvent {
  final String itemId;
  final int userId;
  DeleteItem(this.itemId, this.userId);
}

class FetchUserName extends ItemEvent {
  final String userId;
  FetchUserName(this.userId);
}

class ResolveItem extends ItemEvent {
  final String itemId;
  final bool isProfile;
  final int userId;
  ResolveItem(this.itemId, this.isProfile, this.userId);
}
