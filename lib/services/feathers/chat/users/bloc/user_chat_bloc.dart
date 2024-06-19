import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:random_job/services/feathers/chat/users/model/user_model.dart';
import 'package:random_job/services/feathers/chat/users/repository/user_repository.dart';

part 'user_chat_event.dart';
part 'user_chat_state.dart';

class UserChatBloc extends Bloc<UserChatEvent, UserChatState> {
  final UserRepository _userRepository;
  late final StreamSubscription _subscription;

  UserChatBloc(UserRepository userRepository)
      : _userRepository = userRepository,
        super(
          UserChatInitState(),
        ) {
    _subscription = _userRepository.getUsersStream().listen((event) {
      // print(event);
      final users = event.map((e) => UserModel.fromJson(e)).toList();
      add(
        UserChatLoadEvent(users),
      );
    });
    on<UserChatEvent>(
      (_, emit) => emit(
        UserChatLoadingState(),
      ),
    );
    on<UserChatLoadEvent>(_loadUsers);
    on<UserChatErrorEvent>(
      (event, emit) => emit(
        UserChatErrorState(event.message),
      ),
    );
  }
  _loadUsers(UserChatLoadEvent event, Emitter emit) {
    if (event.users.isNotEmpty) {
      emit(
        UserChatSuccessState(event.users),
      );
    }
  }

  @override
  Future<void> close() async {
    super.close();

    await _subscription.cancel();
  }
}
