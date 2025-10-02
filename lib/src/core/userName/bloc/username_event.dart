part of 'username_bloc.dart';

abstract class UsernameEvent extends Equatable {
  const UsernameEvent();

  @override
  List<Object> get props => [];
}

final class UserNameRequest extends UsernameEvent {
  final String userId;
  const UserNameRequest(this.userId);

  @override
  List<Object> get props => [userId];
}