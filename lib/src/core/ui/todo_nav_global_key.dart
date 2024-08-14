import 'package:flutter/material.dart';

class ToDoNavGlobalKey {
  static ToDoNavGlobalKey? _instance;
  final navKey = GlobalKey<NavigatorState>();

  ToDoNavGlobalKey._();

  static ToDoNavGlobalKey get instance =>
      _instance ??= ToDoNavGlobalKey._();
}
