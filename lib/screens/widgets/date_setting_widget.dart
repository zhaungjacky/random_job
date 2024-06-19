import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DateSettingGestureDetector extends StatelessWidget {
  const DateSettingGestureDetector({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
    required this.icon,
    required this.color,
    required this.title,
  });

  final double width;
  final double height;
  final Icon icon;
  final Color color;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Gap(10),
            icon,
            Text(title),
          ],
        ),
      ),
    );
  }
}
