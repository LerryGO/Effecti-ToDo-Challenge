import 'package:flutter/material.dart';

import '../features/auth/login/login_page.dart';
import '../features/todo/cubit/todo_route.dart';

abstract class AppRoutes {
  static const String login = '/auth/login';
  static const String userRegister = '/auth/register';
  static const String todo = '/todo';
  static const String createTask = '/todo/create';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    todo: (context) => TodoRoute.page,
  };
}
