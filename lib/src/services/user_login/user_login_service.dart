import 'package:todo_challenge/src/models/user_model.dart';

import '../../core/exceptions/service_exception.dart';
import '../../core/fp/either.dart';


abstract interface class UserLoginService {
  Future<Either<ServiceException, UserModel>> execute(String email, String password);
}
