import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/fp/either.dart';
import '../../core/fp/nil.dart';
import '../../core/restClient/rest_client.dart';
import '../../models/task_model.dart';
import 'task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final RestClient restClient;

  TaskRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryException, TaskModel>> createTask() {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryException, Nil>> deleteTask(int id) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryException, List<TaskModel>>> getAllTasks() async {
    try {
      final Response(data: List dataList) = await restClient.auth.get(
        '/tasks',
        queryParameters: {
          'user_id': '#userAuthRef',
        },
      );

      final tasks = dataList
          .map(
            (e) => TaskModel.fromJson(e),
          )
          .toList();

      return Success(tasks);
    } on DioException catch (e, s) {
      log('Erro ao buscar tarefas do banco de dados remoto',
          error: e, stackTrace: s);
      return Failure(
        RepositoryException(
            message: 'Erro ao buscar tarefas do banco de dados remoto'),
      );
    }
  }

  @override
  Future<Either<RepositoryException, TaskModel>> getTask(int id) {
    // TODO: implement getTask
    throw UnimplementedError();
  }

  @override
  Future<Either<RepositoryException, TaskModel>> updateTask(TaskModel task) {
    // TODO: implement updateTask
    throw UnimplementedError();
  }
}
