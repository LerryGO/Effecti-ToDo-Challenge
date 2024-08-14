import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/task_service.dart';
import '../todo_page.dart';
import 'todo_cubit.dart';

class TodoRoute {
  TodoRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<TaskService>(
            create: (context) => TaskService(),
          ),
          Provider<TodoCubit>(
            create: (context) =>
                TodoCubit(taskService: context.read<TaskService>()),
          ),
        ],
        child: const TodoPage(),
      );
}
