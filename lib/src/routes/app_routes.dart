import 'package:flutter/material.dart';

import '../features/auth/login/login_route.dart';
import '../features/auth/register/register_route.dart';
import '../features/todo/todo_route.dart';

abstract class AppRoutes {
  static const String login = '/auth/login';
  static const String userRegister = '/auth/register';
  static const String todo = '/todo';
  static const String createTask = '/todo/create';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => LoginRoute.page,
    userRegister: (context) => RegisterRoute.page,
    todo: (context) => TodoRoute.page,
  };
}
