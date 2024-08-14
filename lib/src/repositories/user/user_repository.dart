import '../../core/exceptions/repository_exception.dart';
import '../../core/fp/either.dart';
import '../../core/fp/nil.dart';

abstract class UserRepository {
  Future<Either<Exception, String>> login(
      String email, String password);

  Future<Either<RepositoryException, Nil>> register(
      ({String name, String email, String password}) userData);
}
