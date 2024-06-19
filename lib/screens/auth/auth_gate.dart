import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_job/screens/auth/bloc/auth_bloc.dart';
import 'package:random_job/screens/auth/login_screen.dart';
import 'package:random_job/screens/home/home_screend.dart';
import 'package:random_job/screens/screens.dart';
// import 'package:random_job/services/services.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  static String route() => "/";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        switch (state) {
          case AuthInitial():
            return const Loader();
          case AuthUnauthedState():
            return const LoginScreen();
          case AuthAuthedState():
            return HomeScreen(
              user: state.user,
            );
        }
      },
    );
  }
}
