import 'package:flutter/material.dart';

import 'core/application_binding.dart';
import 'core/ui/todo_nav_global_key.dart';
import 'core/ui/todo_theme.dart';
import 'routes/app_routes.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'To-Do App',
        theme: TodoTheme.themeData,
        navigatorKey: ToDoNavGlobalKey.instance.navKey,
        locale: const Locale('pt', 'BR'),
        initialRoute: AppRoutes.todo,
        routes: AppRoutes.routes,
      ),
    );
  }
}
