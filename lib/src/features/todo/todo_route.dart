import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../data/app_data.dart';
import '../../services/task_service.dart';
import 'todo_page.dart';
import 'cubits/todo_cubit.dart';

class TodoRoute {
  TodoRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<AppData>(create: (context) => context.read<AppData>() ,),
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
