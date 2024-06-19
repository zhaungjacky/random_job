part of 'todo_bloc.dart';

enum EnumTodoStatus { initial, loaded, error }

// class TodoState extends Equatable {
//   final List<TodoModel> lists;
//   final EnumTodoStatus status;
//   final Timestamp? startAt;
//   final Timestamp? endAt;
//   const TodoState({
//     this.lists = const [],
//     this.status = EnumTodoStatus.initial,
//     this.startAt,
//     this.endAt,
//   });

//   TodoState copyWith({
//     required List<TodoModel> lists,
//     required EnumTodoStatus status,
//     required Timestamp startAt,
//     required Timestamp endAt,
//   }) =>
//       TodoState(
//         lists: lists,
//         status: status,
//         startAt: startAt,
//         endAt: endAt,
//       );
//   @override
//   List<Object?> get props => [
//         lists,
//         status,
//         startAt,
//         endAt,
//       ];
// }

@immutable
sealed class TodoState {
  const TodoState();
}

final class TodoInitState extends TodoState {}

final class TodoLoadingState extends TodoState {}

final class TodoSuccessState extends TodoState {
  final List<TodoModel> lists;
  final Timestamp? startAt;
  final Timestamp? endAt;
  const TodoSuccessState({
    this.lists = const [],
    this.startAt,
    this.endAt,
  });

  TodoSuccessState copyWith({
    required List<TodoModel> lists,
    required Timestamp startAt,
    required Timestamp endAt,
  }) =>
      TodoSuccessState(
        lists: lists,
        startAt: startAt,
        endAt: endAt,
      );
}

final class TodoErrorState extends TodoState {
  final String message;

  const TodoErrorState(this.message);
}
