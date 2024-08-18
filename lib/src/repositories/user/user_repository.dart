import 'package:todo_challenge/src/models/user_model.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/fp/either.dart';
import '../../core/fp/nil.dart';

abstract class UserRepository {
  Future<Either<Exception, String>> login(String email, String password);

  Future<Either<RepositoryException, Nil>> register(
      ({String name, String email, String password}) userData);

  Future<Either<RepositoryException, UserModel>> getUser();
}
