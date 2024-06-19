import 'package:flutter/material.dart';
import 'package:random_job/screens/widgets/widgets.dart';

Future<dynamic> handleBool(BuildContext context, [String? title]) {
  return showDialog(
    context: context,
    builder: (content) {
      return AlertDialog(
        title: Text(
          title ?? "Delete item?",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          MyMaterialButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            icon: const Icon(
              Icons.done,
              size: 32,
              color: Colors.red,
            ),
          ),
          MyMaterialButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            icon: const Icon(
              Icons.cancel,
              size: 32,
              color: Colors.green,
            ),
          ),
        ],
      );
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(
      //   const SnackBar(
      //       content: Text("Delete item!")),
      // );
    },
  );
}
