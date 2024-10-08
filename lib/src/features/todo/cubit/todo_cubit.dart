import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/fp/either.dart';
import '../../../models/task_model.dart';
import '../../../services/task_service.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TaskService _taskService;

  TodoCubit({required TaskService taskService})
      : _taskService = taskService,
        super(TodoState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: TodoStateStatus.loading));
    final tasks = await _taskService.getAllTasks();
    switch (tasks) {
      case Success(value: final taskList):
        emit(state.copyWith(status: TodoStateStatus.loaded, tasks: taskList));
      case Failure(:final exception):
        emit(state.copyWith(
            status: TodoStateStatus.error, errorMessage: exception.message));
    }
  }

  Future<void> addTask(TaskModel task) async {
    emit(state.copyWith(status: TodoStateStatus.loading));
    final result = await _taskService.addTask(task);
    switch (result) {
      case Success(value: final id):
        final newTask = [...state.tasks];
        newTask.add(task.copyWith(id: id));

        emit(state.copyWith(status: TodoStateStatus.loaded, tasks: newTask));
      case Failure(:final exception):
        emit(state.copyWith(
            status: TodoStateStatus.error, errorMessage: exception.message));
    }
  }

  Future<void> removeTask(int taskId) async {
    emit(state.copyWith(status: TodoStateStatus.loading));
    final result = await _taskService.removeTask(taskId);
    switch (result) {
      case Success():
        final newTask = [...state.tasks];
        newTask.removeWhere(
          (element) => element.id == taskId,
        );

        emit(state.copyWith(status: TodoStateStatus.loaded, tasks: newTask));
      case Failure(:final exception):
        emit(state.copyWith(
            status: TodoStateStatus.error, errorMessage: exception.message));
    }
  }

  Future<void> editTask(TaskModel task) async {
    emit(state.copyWith(status: TodoStateStatus.loading));
    final result = await _taskService.editTask(task);
    result.when(
      failure: (exception) {
        emit(state.copyWith(
            status: TodoStateStatus.error, errorMessage: exception.message));
      },
      success: (value) {
        final taskList = [...state.tasks];
        final index = taskList.indexWhere(
          (element) => element.id == task.id,
        );

        if (index != -1) {
          taskList[index] = task;
          emit(state.copyWith(status: TodoStateStatus.loaded, tasks: taskList));
        } else {
          taskList.add(task.copyWith(id: value));
          emit(state.copyWith(status: TodoStateStatus.loaded, tasks: taskList));
        }
      },
    );
  }

  void filter(String? status) {
    switch (status) {
      case 'COMPLETED':
        final filteredtasks = [
          ...state.tasks.where((element) => element.isDone)
        ];
        emit(state.copyWith(
            status: TodoStateStatus.filtered, filteredTasks: filteredtasks));
      case 'PENDING':
        final filteredtasks = [
          ...state.tasks.where((element) => !element.isDone)
        ];
        emit(state.copyWith(
            status: TodoStateStatus.filtered, filteredTasks: filteredtasks));
      default:
        emit(state.copyWith(
          status: TodoStateStatus.loaded,
          filteredTasks: [],
        ));
    }
  }

  Future<void> deleteAllCompletedTasks() async {
    await _taskService.deleteAllCompletedTasks();
    load();
  }

  Future<void> getSyncTasks() async {
    final result = await _taskService.getSyncTasks();
    result.when(
      failure: (exception) {
        emit(state.copyWith(errorMessage: exception.message));
      },
      success: (value) {
        final tasks = [...state.tasks];
        tasks.addAll(value);
        emit(state.copyWith(status: TodoStateStatus.loaded, tasks: tasks));
      },
    );
  }
}
