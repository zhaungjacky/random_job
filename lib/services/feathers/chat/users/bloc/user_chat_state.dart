part of 'user_chat_bloc.dart';

@immutable
sealed class UserChatState {
  const UserChatState();
}

final class UserChatInitState extends UserChatState {}

final class UserChatLoadingState extends UserChatState {}

final class UserChatSuccessState extends UserChatState {
  final List<UserModel> users;

  const UserChatSuccessState(this.users);
}

final class UserChatErrorState extends UserChatState {
  final String message;

  const UserChatErrorState(this.message);
}
