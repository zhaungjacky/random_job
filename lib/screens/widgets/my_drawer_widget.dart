import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:random_job/screens/screens.dart';
import 'package:random_job/screens/todo/todo.dart';
import 'package:random_job/services/services.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return SafeArea(
          child: Drawer(
            child: Column(
              children: [
                const DrawerHeader(
                  child: Icon(
                    Icons.access_alarm,
                    size: 60,
                  ),
                ),
                const Gap(12),
                ListTile(
                  leading: const Icon(
                    Icons.window,
                    color: Colors.teal,
                  ),
                  title: const Text("Accounting"),
                  onTap: () {
                    context.push(AccountingScreen.route());
                    context.pop();
                  },
                ),
                const Gap(12),
                ListTile(
                  leading: const Icon(
                    Icons.note_alt,
                    color: Colors.green,
                  ),
                  title: const Text("Todo"),
                  onTap: () {
                    context.push(TodoScreen.route());
                    context.pop();
                  },
                ),
                const Gap(12),
                ListTile(
                  leading: const Icon(
                    Icons.chat,
                    color: Colors.brown,
                  ),
                  title: const Text("Chat"),
                  onTap: () {
                    context.push(ChatScreen.route());
                    context.pop();
                  },
                ),
                const Gap(12),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.blueAccent,
                  ),
                  title: const Text("Profile"),
                  onTap: () {
                    context.push(ProfileScreen.route());
                    context.pop();
                  },
                ),
                const Gap(12),
                ListTile(
                  leading: const Icon(
                    Icons.navigation,
                    color: Colors.pink,
                  ),
                  title: const Text("Map"),
                  onTap: () {
                    context.push(MapScreen.route());
                    context.pop();
                  },
                ),
                const Gap(12),
                ListTile(
                  leading: CupertinoSwitch(
                    value: state.isDarkModel,
                    onChanged: (_) {
                      context.read<ThemeBloc>().add(
                            ToggleThemeEvent(),
                          );
                    },
                  ),
                  title: Text(state.currentStatus),
                  onTap: () {
                    context.read<ThemeBloc>().add(
                          ToggleThemeEvent(),
                        );
                  },
                ),
                const Gap(12),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: const Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  onTap: () async {
                    await singleton<AuthUseCase>().callLogout();
                  },
                ),
                const Gap(12),
              ],
            ),
          ),
        );
      },
    );
  }
}
