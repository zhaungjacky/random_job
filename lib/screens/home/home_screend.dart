import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:random_job/screens/screens.dart';
import 'package:random_job/screens/todo/todo.dart';
import 'package:random_job/services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    final width = WidthProvider.setWidthAndHeight(context)["width"]! * 0.5;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: const [
          AppBarDropdownWidget(),
        ],
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // accounting and map
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeGestureDetector(
                    height: width,
                    width: width,
                    text: 'accounting',
                    containerColor: Colors.orange,
                    icon: Icon(
                      Icons.window_sharp,
                      size: width * 0.5,
                      color: Colors.teal,
                    ),
                    onTap: () {
                      context.push(
                        AccountingScreen.route(),
                      );
                    },
                  ),
                  HomeGestureDetector(
                    height: width,
                    width: width,
                    text: "profile",
                    containerColor: Colors.lightBlue,
                    icon: Icon(
                      Icons.person,
                      color: Colors.pink,
                      size: width * 0.5,
                    ),
                    onTap: () {
                      context.push(
                        ProfileScreen.route(),
                      );
                    },
                  ),
                ],
              ),
              const Gap(20),

              // todo section
              HomeGestureDetector(
                height: width * 1.1,
                width: width * 2,
                text: "todo",
                containerColor: Colors.tealAccent,
                icon: Icon(
                  Icons.task,
                  size: width * 0.8,
                  color: Colors.green,
                ),
                onTap: () {
                  context.push(
                    TodoScreen.route(),
                  );
                },
              ),

              const Gap(20),

              //!chat
              HomeGestureDetector(
                height: width * 1.1,
                width: width * 2,
                text: "chat",
                containerColor: Colors.amber.shade200,
                icon: Icon(
                  Icons.chat,
                  size: width * 0.8,
                  color: Colors.brown,
                ),
                onTap: () {
                  // print(ChatScreen.route());
                  context.push(
                    ChatScreen.route(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeGestureDetector extends StatelessWidget {
  const HomeGestureDetector({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.containerColor,
    required this.icon,
    required this.onTap,
  });

  final String text;
  final double width;
  final double height;
  final Color containerColor;
  final Icon icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Gap(10),
            icon,
            Text(text),
          ],
        ),
      ),
    );
  }
}
