part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {
  const ChatEvent();
}

final class ChatLoadEvent extends ChatEvent {
  final List<MessageModel> lists;

  const ChatLoadEvent(this.lists);
}

final class ChatAddEvent extends ChatEvent {
  final String reciverId;
  final String message;
  final String chatRoomId;

  const ChatAddEvent({
    required this.reciverId,
    required this.message,
    required this.chatRoomId,
  });
}

final class ChatDeleteEvent extends ChatEvent {
  final String messageId;
  final String chatRoomId;

  const ChatDeleteEvent({
    required this.messageId,
    required this.chatRoomId,
  });
}

class ChatUpdateDateEvent extends ChatEvent {
  final Timestamp startAt;
  final Timestamp endAt;

  const ChatUpdateDateEvent({
    required this.startAt,
    required this.endAt,
  });
}

class ChatResetDateEvent extends ChatEvent {}

final class ChatErrorEvent extends ChatEvent {
  final String message;

  const ChatErrorEvent(this.message);
}
