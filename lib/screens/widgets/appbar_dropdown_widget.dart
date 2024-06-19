// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:random_job/screens/auth/bloc/auth_bloc.dart';
import 'package:random_job/screens/screens.dart';
import 'package:random_job/services/entities/use_case.dart';
import 'package:random_job/services/singleton/singleton_service.dart';

class AppBarDropdownWidget extends StatelessWidget {
  const AppBarDropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is! AuthAuthedState) {
          return const AuthGate();
        }
        return Row(
          children: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text(state.user.email!),
                    onTap: () {
                      context.push(ProfileScreen.route());
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Logout"),
                    onTap: () async {
                      await singleton<AuthUseCase>().callLogout();
                      context.read<AuthBloc>().add(
                            AuthUnauthedEvent(),
                          );
                      // context.pop();
                      // context.go(
                      //   AuthGate.route(),
                      // );
                    },
                  ),
                ];
              },
            ),
            const Gap(16),
          ],
        );
      },
    );
  }
}
