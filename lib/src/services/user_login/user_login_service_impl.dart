import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_challenge/src/data/app_data.dart';
import 'package:todo_challenge/src/models/user_model.dart';

import '../../core/constants/local_storage_keys.dart';
import '../../core/exceptions/auth_exception.dart';
import '../../core/exceptions/service_exception.dart';
import '../../core/fp/either.dart';
import '../../repositories/user/user_repository.dart';
import 'user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepository;
  final AppData appData;
  UserLoginServiceImpl({
    required this.userRepository,
    required this.appData,
  });

  @override
  Future<Either<ServiceException, UserModel>> execute(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);
    switch (loginResult) {
      case Success(value: final accessToken):
        final sp = SharedPreferencesAsync();
        sp.setString(LocalStorageKeys.accessToken, accessToken);

        final authResult = await userRepository.getUser();
        return authResult.when(
          success: (value) {
            appData.user = value;
            return Success(value);
          },
          failure: (exception) {
            return Failure(
              ServiceException(message: exception.message),
            );
          },
        );

      case Failure(:final exception):
        switch (exception) {
          case AuthError():
            return Failure(
                ServiceException(message: 'Erro ao realizar Login!'));
          case AuthUnauthorizedException():
            return Failure(
                ServiceException(message: 'Login ou senha inválidos'));
          default:
            return Failure(
                ServiceException(message: 'Erro ao realizar Login!'));
        }
    }
  }
}
