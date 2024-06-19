import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_job/screens/todo/widgets/widgets.dart';
import 'package:random_job/screens/widgets/widgets.dart';
import 'package:random_job/services/feathers/todo/todo.dart';

class TodoUnfinishedWidget extends StatelessWidget {
  const TodoUnfinishedWidget({super.key});

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
            final lists =
                state.lists.where((element) => !element.isChecked).toList();
            return TodoListModel(lists: lists);
        }
      },
    );
  }
}
