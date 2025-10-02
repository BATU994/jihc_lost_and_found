import 'package:bloc/bloc.dart';
import 'package:jihc_landf/src/features/home/data/repositories/itemRepositoryImpl.dart';
import 'package:jihc_landf/src/features/home/domain/entities/itemEntity.dart';
import 'package:jihc_landf/src/features/home/presentation/utils/filter.dart';
import 'package:meta/meta.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepositoryImpl repository;
  List<ItemEntity> _allItems = [];

  ItemBloc(this.repository) : super(ItemInitial()) {
    on<FetchItems>((event, emit) async {
      emit(ItemLoading());
      final result = await repository.fetchItems();
      result.fold((failure) => emit(ItemError(failure.failure)), (items) async {
        _allItems = items;
        emit(ItemLoaded(items, Filter.all));
      });
    });

    on<PostItemRequested>((event, emit) async {
      emit(ItemLoading());
      final result = await repository.addItem(event.item);
      result.fold(
        (failure) => emit(ItemError(failure.failure)),
        (success) => emit(ItemPosted()),
      );
    });
    on<FetchUserItems>((event, emit) async {
      emit(ItemLoading());
      final result = await repository.fetchItems();
      result.fold((failure) => emit(ItemError(failure.failure)), (items) {
        final userItems =
            items.where((item) => item.user_id == event.userId).toList();
        emit(ItemLoaded(userItems, Filter.all));
      });
    });

    on<DeleteItem>((event, emit) async {
      emit(ItemLoading());
      final result = await repository.deleteItem(event.itemId);
      await result.fold(
        (failure) async {
          emit(ItemError(failure.failure));
        },
        (_) async {
          final fetchResult = await repository.fetchItems();
          fetchResult.fold((failure) => emit(ItemError(failure.failure)), (
            items,
          ) {
            _allItems = items;
            emit(ItemLoaded(items, Filter.all));
          });
        },
      );
    });
  }
}
