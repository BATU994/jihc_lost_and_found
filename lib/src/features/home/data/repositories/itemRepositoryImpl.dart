import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jihc_landf/src/core/datasources.dart';
import 'package:jihc_landf/src/features/home/domain/core/fail.dart';
import 'package:jihc_landf/src/features/home/domain/core/success.dart';
import 'package:jihc_landf/src/features/home/domain/entities/itemEntity.dart';
import 'package:jihc_landf/src/features/home/data/models/itemModel.dart';
import 'package:jihc_landf/src/features/home/domain/repositories/itemRepostory.dart';

class ItemRepositoryImpl implements ItemRepository {
  final Dio dio;
  ItemRepositoryImpl(this.dio);

  @override
  Future<Either<Failure, Success>> addItem(ItemEntityPost item) async {
    try {
      final formData = FormData.fromMap({
        'userId': item.user_id,
        'item_name': item.item_name,
        'isLost': item.isLost,
        'desc': item.desc,
        'date': item.date,
        'location': item.location,
        'image': MultipartFile.fromBytes(item.item_image, filename: 'item.jpg'),
        'isResolved': item.isResolved,
      });
      final response = await dio.post(
        '${ApiClient.defaultBaseUrl}/lostandfound',
        data: formData,
        options: Options(followRedirects: true),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        return Left(Failure(failure: 'Failed to add item'));
      } else {
        return Right(Success(success: 'Item added successfully'));
      }
    } catch (e) {
      return Left(Failure(failure: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateItem(ItemModel item) async {
    try {
      await Future.delayed(Duration(milliseconds: 200));
      return Right(unit);
    } catch (e) {
      return Left(Failure(failure: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteItem(String itemId) async {
    try {
      final response = await dio.delete('${ApiClient.defaultBaseUrl}/lostandfound/$itemId'
      );
      await Future.delayed(Duration(milliseconds: 200));
      return Right(unit);
    } catch (e) {
      return Left(Failure(failure: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ItemEntity>>> fetchItems() async {
    try {
      final response = await dio.get('${ApiClient.defaultBaseUrl}/lostandfound');
      if (response.statusCode == 200 && response.data is List) {
        List<ItemEntity> items = (response.data as List)
          .map((item) => ItemModel.fromJson(item))
          .toList();
        return Right(items);
      } else {
        return Left(Failure(failure: 'Failed to fetch items'));
      }
    } catch (e) {
      return Left(Failure(failure: e.toString()));
    }
  }
}