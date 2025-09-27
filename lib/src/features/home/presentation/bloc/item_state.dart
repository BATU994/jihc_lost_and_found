part of 'item_bloc.dart';

abstract class ItemState {}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemLoaded extends ItemState {
  final List<ItemEntity> items;
  final Filter filter;
  ItemLoaded(this.items, this.filter);
}

class ItemError extends ItemState {
  final String message;
  ItemError(this.message);
}

class ItemPosted extends ItemState {}

