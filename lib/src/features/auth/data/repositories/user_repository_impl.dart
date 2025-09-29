import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jihc_landf/src/features/auth/data/models/userModel.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/shared_preferences.dart';
import 'package:jihc_landf/src/features/auth/domain/core/fail.dart';
import 'package:jihc_landf/src/features/auth/domain/entities/user_entity.dart';
import 'package:jihc_landf/src/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  ProfileInfo profileInfo = ProfileInfo();
  final dio = Dio();
  @override
  Future<Either<Failure, UserEntityRegister>> register(
    String username,
    String userType,
    String group,
    String email,
    String password,
    String gender,
  ) async {
    try {
      final response = await dio.post(
        'https://jihcservfixed-production.up.railway.app/auth/register',
        data: {
          'email': email,
          'name': username,
          'group': group,
          'gender': gender,
          'userType': userType,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        final user = UserRegisterModel(
          username: username,
          userType: userType,
          group: group,
          email: email,
          password: password,
          gender: gender,
        );
        return Right(user);
      } else {
        return Left(Failure(failure: 'Failed to register user'));
      }
    } catch (e) {
      return Left(Failure(failure: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await dio.post(
        'https://jihcservfixed-production.up.railway.app/auth/login',
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final accessToken = response.data['access_token'];
        if (accessToken == null) {
          return Left(Failure(failure: 'No access token returned from server'));
        }
        profileInfo.saveProfileInfo(
          response.data["userName"],
          response.data["email"],
          response.data["userType"],
          response.data["group"],
          (response.data["userId"]).toString(),
          response.data["access_token"],
        );
        return Right(
          UserModel(
            username: response.data["userName"],
            userId: response.data["userId"],
            token: accessToken,
            email: response.data["email"],
            userType: response.data["userType"],
            group: response.data["group"],
          ),
        );
      } else {
        return Left(Failure(failure: 'Failed to login user'));
      }
    } catch (e) {
      return Left(Failure(failure: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      return const Right(null);
    } catch (e) {
      return Left(Failure(failure: e.toString()));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    String? token = await profileInfo.getToken();
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }
}
