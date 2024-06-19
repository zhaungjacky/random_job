import 'package:flutter/material.dart';
import 'package:random_job/screens/widgets/my_material_button_widget.dart';

Future<String?> handleTodoDetail(
  BuildContext context,
  TextEditingController controller, [
  String? title,
]) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title ?? "Add Todo",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        content: TextField(
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          controller: controller,
        ),
        actions: [
          MyMaterialButton(
            onPressed: () {
              Navigator.of(context).pop(controller.text);
            },
            icon: const Icon(
              Icons.next_plan_outlined,
              color: Colors.green,
              size: 32,
            ),
          ),
          MyMaterialButton(
            onPressed: () {
              Navigator.of(context).pop(null);
            },
            icon: const Icon(
              Icons.cancel_outlined,
              color: Colors.red,
              size: 32,
            ),
          ),
        ],
      );
    },
  );
}
