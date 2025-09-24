import 'package:dartz/dartz.dart';
import 'package:jihc_landf/src/features/home/data/models/itemModel.dart';
import 'package:jihc_landf/src/features/home/domain/core/fail.dart';
import 'package:jihc_landf/src/features/home/domain/entities/itemEntity.dart';

abstract class ItemRepository {
  Future<Either<Failure, void>> addItem(ItemModel item);
  Future<Either<Failure, void>> updateItem(ItemModel item);
  Future<Either<Failure, void>> deleteItem(String itemId);
  Future<Either<Failure, List<dynamic>>> fetchItems();
}
