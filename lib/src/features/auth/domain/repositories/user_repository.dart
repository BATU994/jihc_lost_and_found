import 'package:dartz/dartz.dart';
import 'package:jihc_landf/src/features/auth/domain/core/fail.dart';
import 'package:jihc_landf/src/features/auth/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntityRegister>> register(
    String username,
    String userType,
    String group,
    String email,
    String password,
    String gender,
  );
  Future<bool> isLoggedIn();
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, void>> logout();
}