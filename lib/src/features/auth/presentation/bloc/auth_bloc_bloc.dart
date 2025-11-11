import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:jihc_landf/src/core/item/domain/core/fail.dart';
import 'package:jihc_landf/src/features/auth/data/models/userModel.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/shared_preferences.dart';
import 'package:jihc_landf/src/features/auth/data/repositories/user_repository_impl.dart';
import 'package:jihc_landf/src/features/auth/domain/entities/user_entity.dart';
import 'package:meta/meta.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserRepositoryImpl userRepository;
  ProfileInfo profileInfo = ProfileInfo();
  AuthBlocBloc(this.userRepository) : super(AuthBlocInitial()) {
    on<AuthRegisterRequested>(_onRegister);
    on<AuthLoginRequested>(_onLogin);
    on<AuthLogoutRequested>(_onLogout);
    on<UserChangeRequested>(_onUserChange);
  }
  Future<void> _onRegister(
    AuthRegisterRequested event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(AuthBlocLoading());
    final result = await userRepository.register(
      event.name,
      event.userType,
      event.group,
      event.email,
      event.password,
      event.gender,
    );
    result.fold(
      (failure) => emit(AuthFailed(failure.failure)),
      (user) => emit(AuthBlocSuccess()),
    );
  }

  Future<void> _onLogin(
    AuthLoginRequested event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(AuthBlocLoading());
    final result = await userRepository.login(event.email, event.password);
    result.fold(
      (failure) => emit(AuthFailed(failure.failure)),
      (user) => emit(AuthBlocAuthenticated(user)),
    );
  }

  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(AuthBlocLoading());
    final result = await userRepository.logout();
    result.fold(
      (failure) => emit(AuthFailed(failure.failure)),
      (_) => emit(AuthBlocUnauthenticated()),
    );
  }

  Future<void> _onUserChange(
    UserChangeRequested event,
    Emitter<AuthBlocState> emit,
  ) async {
    emit(AuthBlocLoading());
    final loginResult = await userRepository.login(
      event.userChanged.email,
      event.validPassword,
    );
    final user = loginResult.fold((failure) => null, (user) => user);
    if (user == null) {
      emit(ChangeFailed('Login Failed'));
    } else {
      final result = await userRepository.userChange(
        event.userChanged,
        event.userId,
      );
      profileInfo.clearProfileInfo();
      profileInfo.saveProfileInfo(
        user.username,
        user.email,
        user.userType,
        user.group,
        user.userId,
        user.token,
      );
      result.fold((failure) => emit(ChangeFailed(failure.failure)), (_) {
        emit(UserDetailChanged());
      });
    }
  }
}
