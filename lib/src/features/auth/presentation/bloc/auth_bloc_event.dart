part of 'auth_bloc_bloc.dart';

@immutable
abstract class AuthBlocEvent {}

class AuthLoginRequested extends AuthBlocEvent {
  final String email;
  final String password;

  AuthLoginRequested({required this.email, required this.password});
}

class AuthRegisterRequested extends AuthBlocEvent {
  final String email;
  final String name;
  final String password;
  final String gender;
  final String group;
  final String userType;

  AuthRegisterRequested({
    required this.email,
    required this.name,
    required this.password,
    required this.gender,
    required this.group,
    required this.userType,
  });
}

class AuthLogoutRequested extends AuthBlocEvent {}

class UserChangeRequested extends AuthBlocEvent {
  final UserChangeModel userChanged;
  final String validPassword;
  final int userId;
  UserChangeRequested({required this.userChanged, required this.userId, required this.validPassword});
}
