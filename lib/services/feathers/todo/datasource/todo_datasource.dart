import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:random_job/services/entities/failure.dart';
import 'package:random_job/services/feathers/todo/todo.dart';
import 'package:random_job/services/utils/utils.dart';

abstract interface class TodoDatasource {
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

class TodoDatasourceImpl implements TodoDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static String mainCollection = "todos";
  static String secondaryCollection = "todo";
  static bool isTodoStreamDescending = true;
  Timestamp _startAt = DateProvider.staticTodoStartAt();

  Timestamp _endAt = DateProvider.staticTodoEndAt();

  @override
  Timestamp get startAt => !isTodoStreamDescending ? _startAt : _endAt;
  @override
  Timestamp get endAt => isTodoStreamDescending ? _startAt : _endAt;

  @override
  String? get userId => _auth.currentUser?.uid;
  // send message

  @override
  Future<Either<Failure, void>> addItem(TodoModel todo) async {
    try {
      await _firestore
          .collection(mainCollection)
          .doc(userId)
          // .set(newMessage.toMap());
          .collection(secondaryCollection)
          .add(
            todo.toMap(),
          );
      return right(null);
    } on FirebaseException catch (err) {
      return left(
        Failure(err.code),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteItem(String id) async {
    try {
      await _firestore
          .collection(mainCollection)
          .doc(userId)
          .collection(secondaryCollection)
          .doc(id)
          .delete();
      return right(null);
    } on FirebaseException catch (err) {
      return left(
        Failure(err.code),
      );
    }
  }

  @override
  Stream<QuerySnapshot> getItems({
    required String mainCollection,
    required String secondartCollection,
    required bool isTodoStreamDescending,
    required Timestamp startAt,
    required Timestamp endAt,
  }) {
    try {
      return _firestore
              .collection(mainCollection)
              .doc(userId)
              .collection(secondaryCollection)
              .orderBy(
                "date",
                descending: isTodoStreamDescending,
              )
              .startAt([startAt]).endAt([endAt]).snapshots()
          as Stream<QuerySnapshot>;
    } on FirebaseException catch (err) {
      throw MyException(err.code);
    }
  }

  @override
  Future<Either<Failure, void>> updateItem(
      String todoId, TodoModel todo) async {
    try {
      await _firestore
          .collection(mainCollection)
          .doc(userId)
          .collection(secondaryCollection)
          .doc(todoId)
          .set(
            todo.toMap(),
          );

      return right(null);
    } on FirebaseException catch (err) {
      return left(
        Failure(err.code),
      );
    }
  }

  @override
  updateStartAndEndDate({
    required Timestamp newStartAt,
    required Timestamp newEndAt,
  }) async {
    if (newStartAt.compareTo(newEndAt) < 0) {
      _startAt = newStartAt;
      _endAt = newEndAt;
    } else {
      _startAt = newEndAt;
      _endAt = newStartAt;
    }
  }

  @override
  resetStartAndEndDate() async {
    _startAt = DateProvider.staticTodoStartAt();
    _endAt = DateProvider.staticTodoEndAt();
  }
}
