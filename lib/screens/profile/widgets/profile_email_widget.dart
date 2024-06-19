import 'package:flutter/material.dart';

class ProfileEmailWidget extends StatelessWidget {
  const ProfileEmailWidget({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        email,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 32,
        ),
      ),
    );
  }
}
