part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object?> get props => [];
}

class LoadTodoEvent extends TodoEvent {
  final List<TodoModel> lists;

  const LoadTodoEvent({required this.lists});
  @override
  List<Object?> get props => [lists];
}

class UpdateTodoDateEvent extends TodoEvent {
  final Timestamp startAt;
  final Timestamp endAt;

  const UpdateTodoDateEvent({
    required this.startAt,
    required this.endAt,
  });
}

class ResetTodoDateEvent extends TodoEvent {}

class ErrorTodoEvent extends TodoEvent {
  final String message;

  const ErrorTodoEvent(this.message);
}
