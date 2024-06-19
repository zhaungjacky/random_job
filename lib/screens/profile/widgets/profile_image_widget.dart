import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    super.key,
    required this.imageUrl,
    required this.size,
  });
  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
        ),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            imageUrl,
          ),
          radius: size / 2,
        )
        // Center(
        //   child:
        // Image.network(
        //     imageUrl,
        //     height: size,
        //     width: size,
        //     fit: BoxFit.cover,
        //   ),
        // ),
        );
  }
}
