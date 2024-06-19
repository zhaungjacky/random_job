import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_job/screens/auth/bloc/auth_bloc.dart';
import 'package:random_job/screens/auth/login_screen.dart';
import 'package:random_job/screens/profile/widgets/widgets.dart';
import 'package:random_job/screens/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static String route() => "/profile";

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
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Profile"),
                  centerTitle: true,
                  actions: const [
                    AppBarDropdownWidget(),
                  ],
                  bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: TabBar(
                      indicatorColor: Colors.green,
                      tabs: [
                        Text("image"),
                        Text("userId"),
                        Text("email"),
                      ],
                    ),
                  ),
                ),
                body: TabBarView(
                  children: [
                    const ProfileImageWidget(
                      imageUrl:
                          "https://t7.baidu.com/it/u=3632012520,3010336236&fm=193&f=GIF",
                      size: 80,
                    ),
                    ProfileUserIdWidget(userId: state.user.uid),
                    ProfileEmailWidget(email: state.user.email!),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
