import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:random_job/services/entities/failure.dart';
import 'package:random_job/services/feathers/todo/todo.dart';

abstract interface class TodoRepository {
  Future<Either<Failure, void>> addItem(TodoModel todo);
  Future<Either<Failure, void>> deleteItem(String id);
  Future<Either<Failure, void>> updateItem(String todoId, TodoModel todo);
  Stream<QuerySnapshot> getItems({
    required String mainCollection,
    required String secondartCollection,
    required bool isTodoStreamDescending,
    required Timestamp startAt,
    required Timestamp endAt,
  });

  updateStartAndEndDate({
    required Timestamp newStartAt,
    required Timestamp newEndAt,
  });
  resetStartAndEndDate();
  String? get userId;
  Timestamp get startAt;
  Timestamp get endAt;
}

class TodoRepositoryImpl implements TodoRepository {
  final TodoDatasource _todoDatasource;

  TodoRepositoryImpl(
    TodoDatasource todoDatasource,
  ) : _todoDatasource = todoDatasource;

  static String mainCollection() => "todos";
  static String secondaryCollection() => "todo";
  static bool isTodoStreamDescending() => true;

  @override
  Future<Either<Failure, void>> addItem(TodoModel todo) async {
    return await _todoDatasource.addItem(todo);
  }

  @override
  Future<Either<Failure, void>> deleteItem(String id) async {
    return await _todoDatasource.deleteItem(id);
  }

  @override
  Stream<QuerySnapshot<Object?>> getItems({
    required String mainCollection,
    required String secondartCollection,
    required bool isTodoStreamDescending,
    required Timestamp startAt,
    required Timestamp endAt,
  }) {
    return _todoDatasource.getItems(
      mainCollection: mainCollection,
      secondartCollection: secondartCollection,
      isTodoStreamDescending: isTodoStreamDescending,
      startAt: startAt,
      endAt: endAt,
    );
  }

  @override
  Future<Either<Failure, void>> updateItem(
    String todoId,
    TodoModel todo,
  ) async {
    return await _todoDatasource.updateItem(
      todoId,
      todo,
    );
  }

  @override
  Timestamp get endAt => _todoDatasource.endAt;

  @override
  resetStartAndEndDate() {
    _todoDatasource.resetStartAndEndDate();
  }

  @override
  Timestamp get startAt => _todoDatasource.startAt;

  @override
  updateStartAndEndDate({
    required Timestamp newStartAt,
    required Timestamp newEndAt,
  }) {
    _todoDatasource.updateStartAndEndDate(
      newStartAt: newStartAt,
      newEndAt: newEndAt,
    );
  }

  @override
  String? get userId => _todoDatasource.userId;
}
