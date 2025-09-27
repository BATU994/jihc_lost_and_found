import 'package:jihc_landf/src/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String username,
    required String token,
    required int userId,
    required String email,
    required String userType,
    required String group,
  }) : super(username: username, token: token, userId: userId, email: email, userType: userType, group: group);

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
    required String username,
    required String userType,
    required String group,
    required String email,
    required String password,
    required String gender,
  }) : super(
          username: username,
          userType: userType,
          group: group,
          email: email,
          password: password,
          gender: gender,
        );
      factory UserRegisterModel.fromJson(Map<String, dynamic> json) {
        return UserRegisterModel(
          username: json['username'],
          userType: json['userType'],
          group: json['group'],
          email: json['email'],
          password: json['password'],
          gender: json['gender'],);}}