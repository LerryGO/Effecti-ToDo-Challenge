import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:todo_challenge/src/core/exceptions/repository_exception.dart';
import 'package:todo_challenge/src/repositories/task/task_repository.dart';

import '../core/exceptions/service_exception.dart';
import '../core/fp/either.dart';
import '../core/fp/nil.dart';
import '../models/task_model.dart';
import 'database/local_database.dart';

class TaskService {
  final LocalDatabase localDatabase = LocalDatabase();
  final TaskRepository taskRepository;

  TaskService({required this.taskRepository});

  Future<Either<ServiceException, List<TaskModel>>> getAllTasks() async {
    try {
      final result = await localDatabase.db.then(
        (db) => db.taskModels.where().findAll(),
      );
      return Success(result);
    } on Exception catch (e, s) {
      log('Erro ao buscar lista de tarefas no banco local',
          error: e, stackTrace: s);
      return Failure(ServiceException(
          message: 'Erro ao buscar lista de tarefas no banco local'));
    }
  }

  Future<Either<ServiceException, int>> addTask(TaskModel task) async {
    try {
      final id = await localDatabase.db.then(
        (db) => db.writeTxn(() async {
          return await db.taskModels.put(task);
        }),
      );
      return Success(id);
    } on Exception catch (e, s) {
      log('Erro ao adicionar nova tarefa no banco local',
          error: e, stackTrace: s);
      return Failure(
        ServiceException(
            message: 'Erro ao adicionar nova tarefa no banco local'),
      );
    }
  }

  Future<Either<ServiceException, Nil>> removeTask(int taskId) async {
    final result = await localDatabase.db.then(
      (db) async => await db.writeTxn(
        () async {
          return await db.taskModels.delete(taskId);
        },
      ),
    );

    switch (result) {
      case true:
        return Success(nil);
      case false:
        return Failure(ServiceException(message: 'Erro ao remover tarefa'));
    }
  }

  Future<Either<ServiceException, int>> editTask(TaskModel task) async {
    try {
      final id = await localDatabase.db.then(
        (db) async => await db.writeTxn(
          () async {
            return await db.taskModels.put(task);
          },
        ),
      );

      return Success(id);
    } on Exception catch (e, s) {
      log('Erro ao editar tarefa no banco local', error: e, stackTrace: s);
      return Failure(
        ServiceException(message: 'Erro ao editar tarefa no banco local'),
      );
    }
  }

  Future<Either<ServiceException, Nil>> deleteAllCompletedTasks() async {
    try {
      await localDatabase.db.then(
        (db) async => await db.writeTxn(() async {
          final tasksToDelete =
              await db.taskModels.filter().isDoneEqualTo(true).findAll();

          await db.taskModels
              .deleteAll(tasksToDelete.map((task) => task.id!).toList());
        }),
      );

      return Success(nil);
    } on Exception catch (e, s) {
      log('Erro ao deletar todas tarefas no banco local',
          error: e, stackTrace: s);
      return Failure(
        ServiceException(
            message: 'Erro ao deletar todas tarefas no banco local'),
      );
    }
  }

  Future<Either<RepositoryException, List<TaskModel>>> getSyncTasks() async {
    final result = await taskRepository.getAllTasks();
    return result.when(
      failure: (exception) {
        return Failure(exception);
      },
      success: (value) async {
        for (TaskModel task in value) {
          addTask(task);
        }
        return Success(value);
      },
    );
  }

  Future<Either<RepositoryException, List<TaskModel>>> syncTasks(
      List<TaskModel> syncTasks) async {
    final tasksToUpload = <TaskModel>[];
    final result = await getAllTasks();
    switch (result) {
      case Success(value: final tasksList):
        final uploadList = tasksList
            .where(
              (element) => element.cloudId == null,
            )
            .toList();
        tasksToUpload.addAll(uploadList);
        return Success(tasksToUpload);
      case Failure(:final exception):
        return Failure(
          RepositoryException(message: exception.message),
        );
    }
  }
}
