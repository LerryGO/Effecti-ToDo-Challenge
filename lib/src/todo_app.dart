import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale('pt', 'BR'),
        supportedLocales: const [
          Locale('pt', 'BR'), // Português Brasil
        ],
        initialRoute: AppRoutes.todo,
        routes: AppRoutes.routes,
      ),
    );
  }
}
