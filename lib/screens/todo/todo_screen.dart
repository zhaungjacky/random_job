import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_job/screens/screens.dart';
import 'package:random_job/screens/todo/todo.dart';
import 'package:random_job/services/feathers/todo/bloc/todo_bloc.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  static String route() => "/todo";

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  int _currentIndex = 0;
  final _pages = <Widget>[
    const TodoUnfinishedWidget(),
    const TodoDoneWidget(),
    const TodoAllWidget(),
    const TodoSettingWidget(),
  ];
  final _titles = <String>[
    "Not yet",
    "Done",
    "All",
    "Setting",
  ];
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
            return Scaffold(
              appBar: AppBar(
                title: Text(_titles[_currentIndex]),
                centerTitle: true,
                // actions: const [AppBarDropdownWidget()],
              ),
              body: _pages[_currentIndex],
              bottomNavigationBar: NavigationBar(
                selectedIndex: _currentIndex,
                indicatorColor: Colors.green,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.wifi_protected_setup_sharp),
                    label: "not yet",
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.done),
                    label: "done",
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.all_inbox),
                    label: "all",
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.settings),
                    label: "setting",
                  ),
                ],
                onDestinationSelected: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
              ),
            );
        }
      },
    );
  }
}
