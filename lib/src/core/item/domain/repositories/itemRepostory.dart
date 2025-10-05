import 'package:dartz/dartz.dart';
import 'package:jihc_landf/src/core/item/data/models/itemModel.dart';
import 'package:jihc_landf/src/core/item/domain/core/fail.dart';
import 'package:jihc_landf/src/core/item/domain/core/success.dart';
import 'package:jihc_landf/src/core/item/domain/entities/itemEntity.dart';

abstract class ItemRepository {
  Future<Either<Failure, Success>> addItem(ItemEntityPost item);
  Future<Either<Failure, Success>> resolveItem(String itemId);
  Future<Either<Failure, Unit>> deleteItem(String itemId);
  Future<Either<Failure, List<ItemEntity>>> fetchItems();
}
