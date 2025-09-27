part of 'item_bloc.dart';

@immutable
abstract class ItemEvent {}

class FetchItems extends ItemEvent {}


class PostItemRequested extends ItemEvent {
  final ItemEntityPost item;
  PostItemRequested({required this.item});
}

class FetchUserItems extends ItemEvent {
  final String userId;
  FetchUserItems(this.userId);
}

class DeleteItem extends ItemEvent {
  final String itemId;
  DeleteItem(this.itemId);
}