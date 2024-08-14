import 'package:flutter/material.dart';

import '../../models/task_model.dart';

class CreateTask extends StatelessWidget {
  final TaskModel? task;

  const CreateTask({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task != null ? 'Editar tarefa' : 'Nova tarefa'),
      ),
      body: Container(),
    );
  }
}
