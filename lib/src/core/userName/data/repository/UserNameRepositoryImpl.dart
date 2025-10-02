import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jihc_landf/src/core/datasources.dart';
import 'package:jihc_landf/src/core/userName/domain/repository/UsernameRepositry.dart';
import 'package:jihc_landf/src/features/auth/domain/core/fail.dart';

class UserNameRepositoryImpl implements UserNameRepository {
  final Dio dio;
  UserNameRepositoryImpl(this.dio);

  @override
  Future<Either<Failure, String>> fetchUserName(String userId) async {
    try {
      final response = await dio.get(
        '${ApiClient.defaultBaseUrl}/users/get/user/$userId/name',
      );
      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final String userName = response.data['full_name'];
        if (userName is String) {
          return Right(userName);
        } else {
          return Left(Failure(failure: 'Username not found in response'));
        }
      } else {
        return Left(Failure(failure: 'Failed to fetch username'));
      }
    } catch (e) {
      return Left(Failure(failure: e.toString()));
    }
  }
}
