part of 'username_bloc.dart';

abstract class UsernameState extends Equatable {
  const UsernameState();
  
  @override
  List<Object> get props => [];
}

final class UsernameInitial extends UsernameState {}

final class UsernameLoading extends UsernameState {}
 
final class UsernameError extends UsernameState {
  final String message;
  const UsernameError(this.message);

  @override
  List<Object> get props => [message];
}

final class UsernameLoaded extends UsernameState {
  final String username;
  const UsernameLoaded(this.username);

  @override
  List<Object> get props => [username];
}