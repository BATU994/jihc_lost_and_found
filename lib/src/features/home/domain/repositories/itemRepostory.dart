import 'package:dartz/dartz.dart';
import 'package:jihc_landf/src/features/home/data/models/itemModel.dart';
import 'package:jihc_landf/src/features/home/domain/core/fail.dart';
import 'package:jihc_landf/src/features/home/domain/core/success.dart';
import 'package:jihc_landf/src/features/home/domain/entities/itemEntity.dart';

abstract class ItemRepository {
  Future<Either<Failure, Success>> addItem(ItemEntityPost item);
  Future<Either<Failure, Unit>> updateItem(ItemModel item);
  Future<Either<Failure, Unit>> deleteItem(String itemId);
  Future<Either<Failure, List<ItemEntity>>> fetchItems();
}
