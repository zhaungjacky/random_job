import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_job/screens/todo/todo.dart';
import 'package:random_job/screens/widgets/widgets.dart';
import 'package:random_job/services/feathers/todo/bloc/todo_bloc.dart';

class TodoAllWidget extends StatelessWidget {
  const TodoAllWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        switch (state) {
          case TodoInitState():
            return const SizedBox.shrink();
          case TodoLoadingState():
            return const Loader();
          case TodoErrorState():
            return InitTextWidget(
              text: state.message,
            );
          case TodoSuccessState():
            return TodoListModel(lists: state.lists);
        }
      },
    );
  }
}
