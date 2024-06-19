// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:random_job/screens/accounting/widgets/widgets.dart';
import 'package:random_job/screens/todo/todo.dart';
import 'package:random_job/screens/todo/utils/utils.dart';
import 'package:random_job/screens/widgets/widgets.dart';
import 'package:random_job/services/feathers/todo/todo.dart';
import 'package:random_job/services/singleton/singleton_service.dart';
import 'package:random_job/services/utils/width_provider.dart';

class TodoListModel extends StatefulWidget {
  const TodoListModel({
    super.key,
    required this.lists,
  });
  final List<TodoModel> lists;

  static String router() => "/todo";

  @override
  State<TodoListModel> createState() => _TodoListModelState();
}

class _TodoListModelState extends State<TodoListModel> {
  final TextEditingController controller = TextEditingController();

  final TodoRepository todoService = singleton<TodoRepository>();

  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> deleteTodo(String id) async {
      await todoService.deleteItem(id);
    }

    final width =
        WidthProvider.setWidthAndHeight(context)[WidthProvider.widthStr];
    final height =
        WidthProvider.setWidthAndHeight(context)[WidthProvider.heightStr];

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: width,
            height: height! * 0.82,
            child: Stack(
              children: [
                // BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
                if (widget.lists.isEmpty)
                  const InitTextWidget(
                    text: "no todo . . .",
                  )
                else
                  TodoListViewWidget(
                    data: widget.lists,
                    deleteTodo: deleteTodo,
                    controller: controller,
                    scrollController: scrollController,
                    context: context,
                    todoService: todoService,
                  ),

                // TodoSetDurationWidget(todoService: todoService),
                // TodoResetDurationWidget(width: width),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          TodoUtils.addTodo(
            context,
            controller,
            todoService,
          );
        },
        child: const Icon(Icons.save_as),
      ),
    );
  }
}

class TodoResetDurationWidget extends StatelessWidget {
  const TodoResetDurationWidget({
    super.key,
    required this.width,
  });

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: width! * 0.5 - 28,
      child: IconButton(
        onPressed: () async {
          final bool res = await handleBool(
            context,
            "Reset date?",
          );
          if (!res) return;
          context.read<TodoBloc>().add(
                ResetTodoDateEvent(),
              );
        },
        icon: const Icon(
          Icons.restore,
          size: 36,
          color: Colors.green,
        ),
      ),
    );
  }
}

class TodoSetDurationWidget extends StatelessWidget {
  const TodoSetDurationWidget({
    super.key,
    required this.todoService,
  });

  final TodoRepository todoService;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 5,
      child: IconButton(
        tooltip:
            "${DateFormat("M/dd").format(todoService.endAt.toDate())} to ${DateFormat("M/dd").format(
          todoService.startAt.toDate(),
        )}",
        onPressed: () async {
          final DateTime? startAt = await handlePickDateDialog(
            context,
            null,
            "Start Date",
          );
          if (startAt == null) return;
          final DateTime? endAt = await handlePickDateDialog(
            context,
            null,
            "End Date",
          );
          if (endAt == null) return;

          context.read<TodoBloc>().add(
                UpdateTodoDateEvent(
                  startAt: Timestamp.fromDate(startAt),
                  endAt: Timestamp.fromDate(endAt),
                ),
              );
        },
        icon: const Icon(
          Icons.date_range,
          size: 36,
          color: Colors.blue,
        ),
      ),
    );
  }
}

/*
  Widget _listBuilder(
    List<TodoModel> data,
    Future<void> Function(String id) deleteTodo,
    String uid,
    TextEditingController controller,
    ScrollController scrollController,
    BuildContext context,
  ) {
    final messages = data.map((todo) {
      final DateTime date = todo.date.toDate();

      final String text = todo.text;
      final bool isChecked = todo.isChecked;
      final Timestamp createdAt = todo.createdAt;
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
                  return null;
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.background,
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
 */

