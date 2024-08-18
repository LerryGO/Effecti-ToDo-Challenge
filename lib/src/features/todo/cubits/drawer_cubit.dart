import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/user_logout/user_logout_service.dart';

enum DrawerCubitState {
  initial,
  error,
  loading,
  success,
}

class DrawerCubit extends Cubit<DrawerCubitState> {
  final UserLogoutService _userLogoutService;

  DrawerCubit({required UserLogoutService userLogoutService})
      : _userLogoutService = userLogoutService,
        super(DrawerCubitState.initial);

  Future<void> logout() async {
    emit(DrawerCubitState.loading);
    await _userLogoutService.logout();
    emit(DrawerCubitState.success);
  }
}
