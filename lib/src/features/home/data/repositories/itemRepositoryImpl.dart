// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:jihc_landf/src/features/auth/domain/core/fail.dart';
// import 'package:jihc_landf/src/features/auth/domain/entities/user_entity.dart';
// import 'package:jihc_landf/src/features/auth/domain/repositories/user_repository.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:jihc_landf/src/features/home/data/models/itemModel.dart';
// import 'package:jihc_landf/src/features/home/domain/entities/itemEntity.dart';
// import 'package:jihc_landf/src/features/home/domain/repositories/itemRepostory.dart';

// class ItemRepositoryImpl implements ItemRepository {
//   final Dio dio;

//   ItemRepositoryImpl(this.dio);

//   @override
//   Future<Either<Failure, ItemEntity>> addItem(ItemEntity item) async {
//     try {
//       final response = await dio.post(
//         '/items',
//         data: ItemModel.fromEntity(item).toJson(),
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final newItem = ItemModel.fromJson(response.data);
//         return Right(newItem.toEntity());
//       } else {
//         return Left(Failure(failure: 'Failed to add item'));
//       }
//     } catch (e) {
//       return Left(Failure(failure: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, ItemModel>> deleteItem(String itemId) async {
//     throw UnimplementedError();
//   }

//   @override
//   Future<Either<Failure, List<ItemModel>>> fetchItems() async {
//     throw UnimplementedError();
//   }

//   @override
//   Future<Either<Failure, ItemModel>> updateItem(ItemModel item) async {
//     throw UnimplementedError();
//   }
// }
