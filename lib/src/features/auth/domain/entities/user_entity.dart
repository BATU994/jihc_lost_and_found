class UserEntity {
  final String username;
  final String userId;
  final String token;
  UserEntity({
    required this.username,
    required this.token,
    required this.userId,
  });
}

class UserEntityRegister {
  final String username;
  final String userType;
  final String group;
  final String email;
  final String password;
  final String gender;
  UserEntityRegister({
    required this.username,
    required this.userType,
    required this.group,
    required this.email,
    required this.password,
    required this.gender,
  });
}
