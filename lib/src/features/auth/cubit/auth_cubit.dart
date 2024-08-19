import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_challenge/src/services/user_register/user_register_service.dart';

import '../../../services/user_login/user_login_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserLoginService _userLoginService;
  final UserRegisterService _userRegisterService;

  AuthCubit({
    required UserLoginService userLoginService,
    required UserRegisterService userRegisterService,
  })  : _userLoginService = userLoginService,
        _userRegisterService = userRegisterService,
        super(const AuthState.initial());

  Future<void> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    final dto = (
      email: email,
      name: name,
      password: password,
    );
    final result = await _userRegisterService.execute(dto);
    emit(state.copyWith(status: AuthStateStatus.loading));
    result.when(
      failure: (error) {
        emit(state.copyWith(status: AuthStateStatus.error));
      },
      success: (_) {
        // LOG USER
        emit(state.copyWith(status: AuthStateStatus.loggedIn));
      },
    );
  }

  Future<void> login({required String email, required String password}) async {
    final result = await _userLoginService.execute(email, password);
    emit(state.copyWith(status: AuthStateStatus.loading));
    result.when(
      failure: (error) {
        emit(
          state.copyWith(
            status: AuthStateStatus.error,
            errorMessage: error.message,
          ),
        );
      },
      success: (_) {
        emit(state.copyWith(status: AuthStateStatus.loggedIn));
      },
    );
  }
}
