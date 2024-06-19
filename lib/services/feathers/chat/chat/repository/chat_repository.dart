import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_job/services/services.dart';

abstract interface class ChatRepository {
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

class ChatRepositoryImpl implements ChatRepository {
  final ChatDatasource chatDatasource;

  ChatRepositoryImpl(this.chatDatasource);

  @override
  Future<void> deleteMessage(
    String messageId,
    String chatRoomId,
  ) async {
    await chatDatasource.deleteMessage(
      messageId,
      chatRoomId,
    );
  }

  @override
  String get email => chatDatasource.email;

  @override
  Timestamp get endAt => chatDatasource.endAt;
  @override
  Timestamp get startAt => chatDatasource.startAt;
  @override
  String? get userId => chatDatasource.userId;
  @override
  Stream<QuerySnapshot<Object?>> getMessages({
    required String chatRoomId,
    required bool isChatStreamDescending,
    required Timestamp startAt,
    required Timestamp endAt,
  }) {
    return chatDatasource.getMessages(
      chatRoomId: chatRoomId,
      isChatStreamDescending: isChatStreamDescending,
      startAt: startAt,
      endAt: endAt,
    );
  }

  @override
  resetStartAndEndDate() {
    chatDatasource.resetStartAndEndDate();
  }

  @override
  Future<void> sendMessage(
    String reciverId,
    String message,
    String chatRoomId,
  ) async {
    await chatDatasource.sendMessage(
      reciverId,
      message,
      chatRoomId,
    );
  }

  @override
  updateStartAndEndDate({
    required Timestamp newStartAt,
    required Timestamp newEndAt,
  }) {
    chatDatasource.updateStartAndEndDate(
      newStartAt: newStartAt,
      newEndAt: newEndAt,
    );
  }
}
