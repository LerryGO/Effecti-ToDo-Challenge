part of 'todo_cubit.dart';

enum TodoStateStatus {
  initial,
  loaded,
  filtered,
  error,
  info,
  loading,
}

class TodoState extends Equatable {
  final TodoStateStatus status;
  final List<TaskModel> tasks;
  final List<TaskModel> filteredTasks;
  final String? errorMessage;
  final String? infoMessage;

  const TodoState({
    required this.status,
    required this.tasks,
    required this.filteredTasks,
    this.errorMessage,
    this.infoMessage,
  });

  @override
  List<Object?> get props =>
      [status, tasks, errorMessage, infoMessage, filteredTasks];

  TodoState.initial()
      : status = TodoStateStatus.initial,
        tasks = [],
        filteredTasks = [],
        errorMessage = null,
        infoMessage = null;

  TodoState copyWith({
    TodoStateStatus? status,
    List<TaskModel>? tasks,
    List<TaskModel>? filteredTasks,
    String? errorMessage,
    String? infoMessage,
  }) {
    return TodoState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      errorMessage: errorMessage ?? this.errorMessage,
      infoMessage: infoMessage ?? this.infoMessage,
    );
  }
}
