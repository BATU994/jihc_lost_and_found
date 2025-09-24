import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jihc_landf/src/features/auth/data/models/userModel.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/secure_storage.dart';
import 'package:jihc_landf/src/features/auth/domain/core/fail.dart';
import 'package:jihc_landf/src/features/auth/domain/entities/user_entity.dart';
import 'package:jihc_landf/src/features/auth/domain/repositories/user_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

class UserRepositoryImpl implements UserRepository {
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
      final response = await dio.post('https://jihcservfixed-production.up.railway.app/auth/register',
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
        final user = UserRegisterModel(username: username, userType: userType, group: group, email: email, password: password, gender: gender);
        return Right(user);
      } else {
        return Left(Failure(failure: 'Failed to register user'));
      }
    } catch (e) {
      return Left(Failure(failure: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try{
      final response = await dio.post('https://jihcservfixed-production.up.railway.app/auth/login',
      data: {
        'username': email,
        'password': password
      });
      if (response.statusCode == 200) {
        final accessToken = response.data['accessToken'];
        final secureStorage = SecureStorage();
        await secureStorage.writeSecureData('token', accessToken);
        final user = UserModel.fromJson(response.data['user']);
        return Right(user);
      }
      else{
        return Left(Failure(failure: 'Failed to register user'));
      }
    }catch (e) {
      return Left(Failure(failure: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final secureStorage = SecureStorage();
      await secureStorage.deleteSecureData('token');
      return const Right(null);
    } catch (e) {
      return Left(Failure(failure: e.toString()));
    }
  }
  @override
  Future<bool> isLoggedIn() async {
    final secureStorage = SecureStorage();
    String? token = await secureStorage.readSecureData('token');
    if (token != null) {
      return true;
    } else {
      return false;
    }
  } 
}
