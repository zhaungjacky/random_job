import 'package:flutter/material.dart';

class MyMaterialButton extends StatelessWidget {
  const MyMaterialButton({
    super.key,
    required this.onPressed,
    this.icon,
  });

  final Function()? onPressed;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      visualDensity: VisualDensity.compact,
      shape: const CircleBorder(eccentricity: 0),
      child: icon,
    );
  }
}
