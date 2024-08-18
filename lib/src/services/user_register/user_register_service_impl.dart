import '../../core/exceptions/service_exception.dart';
import '../../core/fp/either.dart';
import '../../core/fp/nil.dart';
import '../../repositories/user/user_repository.dart';
import '../user_login/user_login_service.dart';
import 'user_register_service.dart';

class UserRegisterServiceImpl implements UserRegisterService {
  final UserRepository _userRepository;
  final UserLoginService _userLoginService;

  UserRegisterServiceImpl(
      {required UserRepository userRepository,
      required UserLoginService userLoginService})
      : _userRepository = userRepository,
        _userLoginService = userLoginService;

  @override
  Future<Either<ServiceException, Nil>> execute(
      ({String email, String name, String password}) userData) async {
    final registerResult = await _userRepository.register(userData);

    switch (registerResult) {
      case Success():
        await _userLoginService.execute(userData.email, userData.password);
        return Success(nil);
      case Failure(:final exception):
        return Failure(
          ServiceException(message: exception.message),
        );
    }
  }
}
