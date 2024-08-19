import 'package:todo_challenge/src/core/fp/nil.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/fp/either.dart';
import '../../models/task_model.dart';

abstract class TaskRepository {
  Future<Either<RepositoryException, TaskModel>> createTask();
  Future<Either<RepositoryException, Nil>> deleteTask(int id);

  Future<Either<RepositoryException, TaskModel>> updateTask(TaskModel task);

  Future<Either<RepositoryException, List<TaskModel>>> getAllTasks();

  Future<Either<RepositoryException, TaskModel>> getTask(int id);
}
