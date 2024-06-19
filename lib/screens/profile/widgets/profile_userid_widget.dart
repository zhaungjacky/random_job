import 'package:flutter/material.dart';

class ProfileUserIdWidget extends StatelessWidget {
  const ProfileUserIdWidget({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          userId,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
