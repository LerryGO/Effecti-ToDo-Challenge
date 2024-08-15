import 'package:flutter/material.dart';

import '../../../models/task_model.dart';
import '../create_task.dart';

class TaskTile extends StatelessWidget {
  final TaskModel _taskModel;
  final VoidCallback onDelete;
  final Function(({TaskModel task, String type})) onEdit;
  final Function(TaskModel) onCheckedPress;

  const TaskTile(
      {super.key,
      required TaskModel taskModel,
      required this.onDelete,
      required this.onEdit,
      required this.onCheckedPress})
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
              Checkbox.adaptive(
                value: _taskModel.isDone,
                onChanged: (value) {
                  onCheckedPress(
                    _taskModel.copyWith(isDone: value),
                  );
                },
              ),
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
                    onPressed: () async {
                      final ({TaskModel task, String type})? result =
                          await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CreateTask(
                            task: _taskModel,
                          ),
                        ),
                      );

                      if (result != null) {
                        onEdit(result);
                      }
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
                    onPressed: onDelete,
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
