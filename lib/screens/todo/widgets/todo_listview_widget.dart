// ignore_for_file: use_build_context_synchronously

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_job/screens/accounting/widgets/widgets.dart';
import 'package:random_job/screens/widgets/widgets.dart';
import 'package:random_job/services/feathers/todo/model/todo_model.dart';
import 'package:random_job/services/feathers/todo/repository/todo_repository.dart';

class TodoListViewWidget extends StatelessWidget {
  const TodoListViewWidget({
    super.key,
    required this.data,
    required this.deleteTodo,
    required this.controller,
    required this.scrollController,
    required this.context,
    required this.todoService,
  });
  final List<TodoModel> data;
  final Future<void> Function(String id) deleteTodo;
  final TextEditingController controller;
  final ScrollController scrollController;
  final BuildContext context;
  final TodoRepository todoService;

  @override
  Widget build(BuildContext context) {
    final messages = data.map((todo) {
      final DateTime date = todo.date.toDate();

      final String text = todo.text;
      final bool isChecked = todo.isChecked;
      final Timestamp createdAt = todo.createdAt;
      final String? uid = todoService.userId;
      if (uid == null) {
        return const InitTextWidget(
          text: "no userId . . .",
        );
      }
      final Color color = todo.date.toDate().compareTo(DateTime.now()) <= 0
          ? Colors.redAccent.shade200
          : Theme.of(context).colorScheme.surface;
      return !todo.isChecked
          ? Container(
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Dismissible(
                key: Key(todo.id.toString()),
                direction: DismissDirection.endToStart,
                confirmDismiss: (_) async {
                  final res = await handleBool(context);
                  if (!res) return;
                  await deleteTodo(todo.id!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Delete todo success . . .',
                        style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                  );
                  return null;
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: color,
                    // color: Theme.of(context).colorScheme.background,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.date_range),
                    title: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd('en-us').format(date),
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    trailing: Checkbox(
                      value: isChecked,
                      onChanged: (value) async {
                        final newTodo = TodoModel(
                          text: text,
                          uid: uid,
                          isChecked: !isChecked,
                          date: todo.date,
                          createdAt: createdAt,
                          id: '',
                        );

                        await todoService.updateItem(
                          todo.id!,
                          newTodo,
                        );
                      },
                    ),
                    onTap: () async {
                      controller.text = text;
                      final String? newtext = await handleTodoDetail(
                        context,
                        controller,
                        "Update todo",
                      );

                      if (newtext == null) {
                        controller.clear();
                        return;
                      }

                      final DateTime? newDate = await handlePickDateDialog(
                        context,
                        date,
                      );
                      if (newDate == null) {
                        controller.clear();
                        return;
                      }

                      final newTodo = TodoModel(
                        text: newtext,
                        uid: uid,
                        isChecked: isChecked,
                        date: Timestamp.fromDate(newDate),
                        createdAt: createdAt,
                        id: '',
                      );

                      controller.clear();
                      await todoService.updateItem(
                        todo.id!,
                        newTodo,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Todo update success . . .',
                            style: TextStyle(
                              fontSize: 22,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.only(bottom: 6),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.green,
                ),
                child: ListTile(
                  leading: const Icon(Icons.date_range),
                  title: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd('en-us').format(date),
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  trailing: Checkbox(
                    value: isChecked,
                    onChanged: (value) async {
                      final newTodo = TodoModel(
                        text: text,
                        uid: uid,
                        isChecked: !isChecked,
                        date: todo.date,
                        createdAt: createdAt,
                        id: '',
                      );

                      await todoService.updateItem(
                        todo.id!,
                        newTodo,
                      );
                    },
                  ),
                ),
              ),
            );
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Column(children: [
        Flexible(
          child: ListView(
            controller: scrollController,
            reverse: true,
            shrinkWrap: true,
            children: UnmodifiableListView(messages),
          ),
        ),
      ]),
    );
  }
}
