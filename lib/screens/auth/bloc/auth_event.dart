part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthAuthedEvent extends AuthEvent {
  final User user;

  AuthAuthedEvent({required this.user});
}

final class AuthUnauthedEvent extends AuthEvent {}
