part of 'auth_bloc_bloc.dart';

@immutable
abstract class AuthBlocState {}

 class AuthBlocInitial extends AuthBlocState {}

 class AuthBlocLoading extends AuthBlocState {}

 class AuthBlocAuthenticated extends AuthBlocState {
  final UserEntity user;
  AuthBlocAuthenticated(this.user);
}

class AuthBlocSuccess extends AuthBlocState {}

class AuthFailed extends AuthBlocState {
  final String failMessage;
  AuthFailed(this.failMessage);
}

class AuthBlocUnauthenticated extends AuthBlocState {}
