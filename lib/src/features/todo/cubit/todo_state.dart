part of 'todo_cubit.dart';

enum TodoStateStatus {
  initial,
  loaded,
  error,
  info,
  loading,
}

class TodoState extends Equatable {
  final TodoStateStatus status;
  final List<TaskModel> tasks;
  final String? errorMessage;
  final String? infoMessage;

  const TodoState(
      {required this.status,
      required this.tasks,
      this.errorMessage,
      this.infoMessage});

  @override
  List<Object?> get props => [status, tasks, errorMessage, infoMessage];

  TodoState.initial()
      : status = TodoStateStatus.initial,
        tasks = [],
        errorMessage = null,
        infoMessage = null;

  TodoState copyWith({
    TodoStateStatus? status,
    List<TaskModel>? tasks,
    String? errorMessage,
    String? infoMessage,
  }) {
    return TodoState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage ?? this.errorMessage,
      infoMessage: infoMessage ?? this.infoMessage,
    );
  }
}
