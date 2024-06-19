part of 'chat_bloc.dart';

@immutable
sealed class ChatState {
  const ChatState();
}

final class ChatInitState extends ChatState {}

final class ChatLoadingState extends ChatState {}

final class ChatSuccessState extends ChatState {
  final List<MessageModel> lists;

  const ChatSuccessState(this.lists);
}

final class ChatErrorState extends ChatState {
  final String message;

  const ChatErrorState(this.message);
}
