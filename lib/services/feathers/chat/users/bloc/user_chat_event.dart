part of 'user_chat_bloc.dart';

@immutable
sealed class UserChatEvent {
  const UserChatEvent();
}

final class UserChatLoadEvent extends UserChatEvent {
  final List<UserModel> users;

  const UserChatLoadEvent(this.users);
}

final class UserChatErrorEvent extends UserChatEvent {
  final String message;

  const UserChatErrorEvent(this.message);
}
