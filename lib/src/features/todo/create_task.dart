import 'package:flutter/material.dart';
import 'package:todo_challenge/src/core/extensions/formatter_extension.dart';
import 'package:todo_challenge/src/features/todo/widgets/date_picker.dart';
import 'package:validatorless/validatorless.dart';

import '../../models/task_model.dart';

class CreateTask extends StatefulWidget {
  final TaskModel? task;

  const CreateTask({super.key, this.task});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final formKey = GlobalKey<FormState>();
  final titleEC = TextEditingController();
  final descriptionEC = TextEditingController();
  final dueDateEC = TextEditingController();
  var addDueDate = false;

  @override
  void dispose() {
    titleEC.dispose();
    descriptionEC.dispose();
    dueDateEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final task = widget.task;
    if (task != null) {
      titleEC.text = task.title;
      descriptionEC.text = task.description;

      if (widget.task?.dueDate != null) {
        dueDateEC.text = task.dueDate!.toIso8601String().toStringCompleteDate;
        addDueDate = true;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task != null ? 'Editar tarefa' : 'Nova tarefa'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: titleEC,
                  decoration: const InputDecoration(
                    label: Text('Título da tarefa'),
                  ),
                  validator: Validatorless.required("Campo obrigatório"),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: descriptionEC,
                  decoration: const InputDecoration(
                    label: Text('Descrição da tarefa'),
                  ),
                  maxLines: 10,
                  minLines: 6,
                  validator: Validatorless.required("Campo obrigatório"),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Checkbox.adaptive(
                      value: addDueDate,
                      onChanged: (value) {
                        setState(() {
                          addDueDate = !addDueDate;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'Adicionar data de vencimento',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
                Offstage(
                  offstage: !addDueDate,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DatePickerWidget(
                      initialDate: widget.task?.dueDate != null
                          ? widget.task?.dueDate!.toIso8601String().toDateTime
                          : DateTime.now(),
                      dateController: dueDateEC,
                      enableValidation: addDueDate,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case null || false:
                        break;
                      case true:
                        final task = widget.task;
                        final dueDateFormat =
                            addDueDate ? dueDateEC.text.toDateTime : null;
                        final dto = (
                          task: TaskModel(
                            id: task?.id,
                            title: titleEC.text,
                            description: descriptionEC.text,
                            createdAt: task?.createdAt ?? DateTime.now(),
                            dueDate: addDueDate ? dueDateFormat : null,
                            isDone: task?.isDone ?? false,
                          ),
                          type: task != null ? 'UPDATE' : 'ADD',
                        );

                        Navigator.of(context).pop(dto);
                    }
                  },
                  child: Text(widget.task != null
                      ? "Finalizar edição"
                      : "Adicionar nova tarefa"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
