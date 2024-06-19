part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthUnauthedState extends AuthState {}

final class AuthAuthedState extends AuthState {
  final User user;

  AuthAuthedState({
    required this.user,
  });
}
