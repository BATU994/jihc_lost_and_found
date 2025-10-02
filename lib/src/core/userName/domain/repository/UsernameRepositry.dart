
import 'package:dartz/dartz.dart';
import 'package:jihc_landf/src/features/auth/domain/core/fail.dart';

abstract class UserNameRepository {
  Future<Either<Failure, String>> fetchUserName(String userId);
}