import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jihc_landf/src/core/datasources.dart';
import 'package:jihc_landf/src/core/item/domain/core/fail.dart';
import 'package:jihc_landf/src/core/item/domain/core/success.dart';
import 'package:jihc_landf/src/core/item/domain/entities/itemEntity.dart';
import 'package:jihc_landf/src/core/item/data/models/itemModel.dart';
import 'package:jihc_landf/src/core/item/domain/repositories/itemRepostory.dart';

class ItemRepositoryImpl implements ItemRepository {
  final Dio dio;
  ItemRepositoryImpl(this.dio);

  @override
  Future<Either<Failure, Success>> addItem(ItemEntityPost item) async {
    try {
      final Map<String, dynamic> fields = {
        'userId': item.user_id.toString(),
        'item_name': item.item_name,
        'userName': item.userName,
        'isLost': item.isLost.toString(),
        'desc': item.desc,
        'date': item.date,
        'location': item.location,
        'isResolved': item.isResolved.toString(),
      };

      if (item.item_image.isNotEmpty) {
        fields['image'] = MultipartFile.fromBytes(
          item.item_image,
          filename: 'item.jpg',
        );
      }

      final formData = FormData.fromMap(fields);
      final response = await dio.post(
        '${ApiClient.defaultBaseUrl}/lostandfound/',
        data: formData,
        options: Options(
          followRedirects: true,
          contentType: 'multipart/form-data',
        ),
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
  Future<Either<Failure, Success>> resolveItem(String itemId) async {
    try {
      final response = await dio.patch(
        ApiClient.defaultBaseUrl + '/lostandfound/' + itemId,
        data: {'isResolved': true},
      );
      if (response.statusCode != 200) {
        return Left(Failure(failure: 'Failed to resolve item'));
      } else {
        return Right(Success(success: 'Item resolved successfully'));
      }
    } catch (e) {
      return Left(Failure(failure: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteItem(String itemId) async {
    try {
      final response = await dio.delete(
        '${ApiClient.defaultBaseUrl}/lostandfound/$itemId',
      );
      if (response.statusCode != 204) {
        return Left(Failure(failure: 'Failed to delete item'));
      } else {
        return Right(unit);
      }
    } catch (e) {
      return Left(Failure(failure: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ItemEntity>>> fetchItems() async {
    try {
      final response = await dio.get(
        '${ApiClient.defaultBaseUrl}/lostandfound/',
      );
      if (response.statusCode == 200 && response.data is List) {
        List<ItemEntity> items =
            (response.data as List)
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
