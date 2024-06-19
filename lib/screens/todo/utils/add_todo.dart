// case TodoInitState():
//           return const SizedBox.shrink();
//         case TodoLoadingState():
//           return const Loader();
//         case TodoErroState():
//           return InitTextWidget(
//             text: state.message,
//           );
//         case TodoSuccessState():
//           return

// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_job/screens/accounting/widgets/widgets.dart';
import 'package:random_job/screens/widgets/widgets.dart';
import 'package:random_job/services/feathers/todo/todo.dart';

class TodoUtils {
  static void addTodo(
    BuildContext context,
    TextEditingController controller,
    TodoRepository todoService,
    // String? uid,
  ) async {
    // if (textController.text.isEmpty) return;
    final String? text =
        await handleTodoDetail(context, controller, "Add todo");
    if (text == null) return;

    final DateTime? date = await handlePickDateDialog(
      context,
    );
    if (date == null || todoService.userId == null) return;

    final newTodo = TodoModel(
      text: text,
      uid: todoService.userId!,
      isChecked: false,
      date: Timestamp.fromDate(date),
      createdAt: Timestamp.now(),
      id: '',
    );

    await todoService.addItem(newTodo);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Add todo success',
          style: TextStyle(
            fontSize: 22,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );

    controller.clear();
  }
}
