import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_challenge/src/features/todo/create_task.dart';
import 'package:todo_challenge/src/features/todo/cubit/todo_cubit.dart';

import '../../../models/task_model.dart';

class TaskTile extends StatelessWidget {
  final TaskModel _taskModel;
  const TaskTile({super.key, required TaskModel taskModel})
      : _taskModel = taskModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _taskModel.title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: _taskModel.isDone
                              ? TextDecoration.lineThrough
                              : null),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      _taskModel.description,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: _taskModel.isDone
                              ? TextDecoration.lineThrough
                              : null),
                    ),
                  ],
                ),
              ),
              Checkbox.adaptive(value: _taskModel.isDone, onChanged: (value) {})
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CreateTask(
                            task: _taskModel,
                          ),
                        ),
                      );
                    },
                    child: const Text('Editar tarefa'),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Provider.of<TodoCubit>(context, listen: false)
                          .removeTask(_taskModel.id!);
                    },
                    child: const Text('Remover tarefa'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
