import 'dart:developer';

import 'package:isar/isar.dart';

import '../core/exceptions/service_exception.dart';
import '../core/fp/either.dart';
import '../core/fp/nil.dart';
import '../models/task_model.dart';
import 'database/local_database.dart';

class TaskService {
  final LocalDatabase localDatabase = LocalDatabase();

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
}
