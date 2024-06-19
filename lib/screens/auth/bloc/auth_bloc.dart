import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final StreamSubscription _subscription;
  AuthBloc() : super(AuthInitial()) {
    _subscription = FirebaseAuth.instance.authStateChanges().listen((event) {
      // print(event);
      if (event != null) {
        add(
          AuthAuthedEvent(
            user: event,
          ),
        );
      } else {
        add(
          AuthUnauthedEvent(),
        );
      }
    });

    on<AuthEvent>(
      (_, emit) => emit(
        AuthInitial(),
      ),
    );
    on<AuthAuthedEvent>(_authed);
    on<AuthUnauthedEvent>(
      (_, emit) => emit(
        AuthUnauthedState(),
      ),
    );
  }
  _authed(AuthAuthedEvent event, Emitter emit) {
    emit(
      AuthAuthedState(
        user: event.user,
      ),
    );
  }

  @override
  Future<void> close() async {
    super.close();

    await _subscription.cancel();
  }
}
