import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_job/services/services.dart';

abstract interface class ChatDatasource {
  Stream<QuerySnapshot> getMessages({
    required String chatRoomId,
    required bool isChatStreamDescending,
    required Timestamp startAt,
    required Timestamp endAt,
  });
  Future<void> sendMessage(
    String reciverId,
    String message,
    String chatRoomId,
  );

  Future<void> deleteMessage(
    String messageId,
    String chatRoomId,
  );

  updateStartAndEndDate({
    required Timestamp newStartAt,
    required Timestamp newEndAt,
  });
  resetStartAndEndDate();
  String? get userId;
  String get email;
  Timestamp get startAt;
  Timestamp get endAt;
}

class ChatDatasourceImpl implements ChatDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static String mainCollection() => "chat_rooms";
  static String secondartCollection() => "messages";
  static String users() => "users";

  static bool isChatStreamDescending() => true;

  Timestamp _startAt = DateProvider.staticChatStartAt();

  Timestamp _endAt = DateProvider.staticChatEndAt();

  @override
  String get userId => _auth.currentUser!.uid;
  @override
  String get email => _auth.currentUser!.email!;

  @override
  Timestamp get startAt => !isChatStreamDescending() ? _startAt : _endAt;
  @override
  Timestamp get endAt => isChatStreamDescending() ? _startAt : _endAt;
  @override
  Future<void> sendMessage(
    String reciverId,
    String message,
    String chatRoomId,
  ) async {
    try {
      final String senderEmail = _auth.currentUser!.email!;
      final Timestamp timestamp = Timestamp.now();

      //create a new messgae
      final newMessage = MessageModel(
        senderId: userId,
        senderEmail: senderEmail,
        reciverId: reciverId,
        message: message,
        timestamp: timestamp,
        id: null,
      );
      // List<String> ids = [userId, reciverId]..sort();

      // final chatRoomId = ids.join("_");

      await _firestore
          .collection(mainCollection())
          .doc(chatRoomId)
          .collection(secondartCollection())
          .add(
            newMessage.toMap(),
          );
    } on FirebaseException catch (err) {
      throw MyException(err.code);
    }
  }

  @override
  Future<void> deleteMessage(
    String messageId,
    String chatRoomId,
  ) async {
    try {
      await _firestore
          .collection(mainCollection())
          .doc(chatRoomId)
          .collection(secondartCollection())
          .doc(messageId)
          .delete();
    } on FirebaseException catch (err) {
      throw MyException(err.code);
    }
  }

  @override
  Stream<QuerySnapshot<Object?>> getMessages({
    required String chatRoomId,
    required bool isChatStreamDescending,
    required Timestamp startAt,
    required Timestamp endAt,
  }) {
    try {
      return _firestore
          .collection(mainCollection())
          .doc(chatRoomId)
          .collection(secondartCollection())
          .orderBy(
            "timestamp",
            descending: isChatStreamDescending,
          )
          .startAt([startAt]).endAt([endAt]).snapshots();
    } on FirebaseException catch (err) {
      throw MyException(err.code);
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
