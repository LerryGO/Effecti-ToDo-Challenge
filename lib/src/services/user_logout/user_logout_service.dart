import '../../core/exceptions/service_exception.dart';
import '../../core/fp/either.dart';
import '../../core/fp/nil.dart';

abstract class UserLogoutService {
  Future<Either<ServiceException, Nil>> logout();
}
