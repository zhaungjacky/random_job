import 'package:flutter/material.dart';

class InitTextWidget extends StatelessWidget {
  const InitTextWidget({
    super.key,
    this.text,
  });
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text ?? "Welcome . . .",
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 32,
        ),
      ),
    );
  }
}
