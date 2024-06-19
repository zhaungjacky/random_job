import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:random_job/screens/screens.dart';
import 'package:random_job/services/auth/auth.dart';
import 'package:random_job/services/feathers/accounting/repository/accounting_repository.dart';
import 'package:random_job/services/services.dart';

class ChatUserWidget extends StatelessWidget {
  const ChatUserWidget({super.key});

  static String route([String? userInfo]) => "/chat/${userInfo ?? ':userInfo'}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserChatBloc, UserChatState>(
        builder: (context, state) {
          switch (state) {
            case UserChatInitState():
              return const SizedBox.shrink();
            case UserChatLoadingState():
              return const Loader();
            case UserChatErrorState():
              return InitTextWidget(
                text: state.message,
              );
            case UserChatSuccessState():
              final users = state.users
                  .where(
                    (user) => user.uid != singleton<AuthRepository>().userId,
                  )
                  .toList();
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final currentUserId =
                      singleton<AccountingRepository>().userId;
                  if (currentUserId == null) {
                    return const InitTextWidget(
                      text: "no user . . .",
                    );
                  }
                  final roomids = [currentUserId, user.uid]
                    ..sort()
                    ..join("_");
                  final userInfoSub = "$roomids&&${user.email}";

                  final userInfo = "${user.uid}&&$userInfoSub";
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                    ),
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(
                          user.email ?? "hello",
                        ),
                        onTap: () {
                          context.push(
                            route(
                              userInfo,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
