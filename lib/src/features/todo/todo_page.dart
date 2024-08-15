import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/ui/helpers/messages.dart';
import '../../models/task_model.dart';
import 'create_task.dart';
import 'cubit/todo_cubit.dart';
import 'widgets/task_tile.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late final TodoCubit controller;
  @override
  void initState() {
    controller = context.read<TodoCubit>();
    controller.load();
    super.initState();
  }

  void addOrUpdateTask(({TaskModel task, String type}) task) {
    switch (task.type) {
      case 'ADD':
        controller.addTask(task.task);

      case 'UPDATE':
        controller.editTask(task.task);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        onPressed: () async {
          final ({TaskModel task, String type})? result =
              await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateTask(),
            ),
          );
          if (result != null) {
            addOrUpdateTask(result);
          }
        },
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.add,
            color: Colors.blue,
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('To-Do List'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      body: BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {
          switch (state.status) {
            case TodoStateStatus.error:
              Messages.showError(state.errorMessage!, context);
              break;

            case TodoStateStatus.info:
              if (state.infoMessage != null) {
                Messages.showSuccess(state.infoMessage!, context);
              }
              break;
            default:
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case TodoStateStatus.loading:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            default:
              return Container(
                padding: const EdgeInsets.all(16),
                child: ListView.separated(
                  itemCount: state.tasks.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                  itemBuilder: (context, index) {
                    final task = state.tasks[index];
                    return TaskTile(
                      taskModel: task,
                      onDelete: () => controller.removeTask(task.id!),
                      onEdit: addOrUpdateTask,
                      onCheckedPress: (task) {
                        controller.editTask(task);
                      },
                    );
                  },
                ),
              );
          }
        },
      ),
    );
  }
}
