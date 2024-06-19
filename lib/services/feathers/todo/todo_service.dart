import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_job/services/auth/repository/auth_repository.dart';
import 'package:random_job/services/feathers/todo/model/todo_model.dart';
import 'package:random_job/services/singleton/singleton_service.dart';
import 'package:random_job/services/utils/utils.dart';

abstract interface class Todo {
  Future<void> addItem(TodoModel todo);
  Future<void> deleteItem(String id);
  Future<void> updateItem(String todoId, TodoModel todo);
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

class TodoService implements Todo {
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

  // send message

  @override
  String? get userId =>
      _auth.currentUser?.uid ?? singleton<AuthRepository>().userId;

  @override
  Future<void> addItem(TodoModel todo) async {
    //get current user info

    //create a new messgae
    // final newMessage = TodoModel(
    //   text: text,
    //   uid: uid,
    //   isChecked: false,
    //   date: Timestamp.fromDate(date),
    //   createAt: Timestamp.now(),
    // );

    await _firestore
        .collection(mainCollection)
        .doc(userId)
        // .set(newMessage.toMap());
        .collection(secondaryCollection)
        .add(todo.toMap());
    // print("created_todo: $res");
  }

  //delete todo
  @override
  Future<void> deleteItem(String id) async {
    //get current user info

    // final collectionRef = _firestore
    //     .collection(mainCollection)
    //     .doc(uid)
    //     .collection(secondaryCollection);

    // collectionRef.get().then((value) => print(value.docs[0].id));
    //0hX0YlelKdxmzwLr9chA

    await _firestore
        .collection(mainCollection)
        .doc(userId)
        .collection(secondaryCollection)
        .doc(id)
        .delete();
  }

  @override
  updateItem(
    String todoId,
    TodoModel todo,
    //   [
    //   String? text,
    //   DateTime? date,
    //   bool? isChecked,
    // ]
  ) async {
    // final String uid = _auth.currentUser!.uid;
    await _firestore
        .collection(mainCollection)
        .doc(userId)
        .collection(secondaryCollection)
        .doc(todoId)
        .set(todo.toMap());
  }

  //get todos

  @override
  Stream<QuerySnapshot> getItems({
    required String mainCollection,
    required String secondartCollection,
    required bool isTodoStreamDescending,
    required Timestamp startAt,
    required Timestamp endAt,
  }) {
    return _firestore
        .collection(mainCollection)
        .doc(userId)
        .collection(secondaryCollection)
        .orderBy(
          "date",
          descending: isTodoStreamDescending,
        )
        .startAt([startAt]).endAt([endAt]).snapshots();
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
