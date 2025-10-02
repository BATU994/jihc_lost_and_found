import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:jihc_landf/src/core/userName/data/repository/UserNameRepositoryImpl.dart';

part 'username_event.dart';
part 'username_state.dart';

class UsernameBloc extends Bloc<UsernameEvent, UsernameState> {
  UsernameBloc(UserNameRepositoryImpl userNameRepositoryImpl) : super(UsernameInitial()) {
    on<UserNameRequest>((event, emit) {
      emit(UsernameLoading());
      final userNameRepository = UserNameRepositoryImpl(Dio());
      userNameRepository.fetchUserName(event.userId).then((result) {
        result.fold(
          (failure) => emit(UsernameError(failure.failure)),
          (userName) => emit(UsernameLoaded(userName)),
        );
      });
    });
  }
}
