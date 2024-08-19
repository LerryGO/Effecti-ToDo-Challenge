import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/restClient/rest_client.dart';
import '../../data/app_data.dart';
import '../../repositories/task/task_repository.dart';
import '../../repositories/task/task_repository_impl.dart';
import '../../services/task_service.dart';
import 'cubit/todo_cubit.dart';
import 'todo_page.dart';

class TodoRoute {
  TodoRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<AppData>(
            create: (context) => context.read<AppData>(),
          ),
          Provider<TaskRepository>(
            create: (context) =>
                TaskRepositoryImpl(restClient: context.read<RestClient>()),
          ),
          Provider<TaskService>(
            create: (context) =>
                TaskService(taskRepository: context.read<TaskRepository>()),
          ),
          Provider<TodoCubit>(
            create: (context) =>
                TodoCubit(taskService: context.read<TaskService>()),
          ),
        ],
        child: const TodoPage(),
      );
}
