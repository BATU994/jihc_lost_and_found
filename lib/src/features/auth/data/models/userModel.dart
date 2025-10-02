import 'package:jihc_landf/src/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.username,
    required super.token,
    required super.userId,
    required super.email,
    required super.userType,
    required super.group,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      token: json['token'],
      userId: json['userId'],
      email: json['email'],
      userType: json['userType'],
      group: json['group'],
    );
  }
}

class UserRegisterModel extends UserEntityRegister {
  UserRegisterModel({
    required super.username,
    required super.userType,
    required super.group,
    required super.email,
    required super.password,
    required super.gender,
  });
  factory UserRegisterModel.fromJson(Map<String, dynamic> json) {
    return UserRegisterModel(
      username: json['username'],
      userType: json['userType'],
      group: json['group'],
      email: json['email'],
      password: json['password'],
      gender: json['gender'],
    );
  }
}
