import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_job/screens/accounting/widgets/widgets.dart';
import 'package:random_job/screens/widgets/widgets.dart';
import 'package:random_job/services/services.dart';
// import 'package:random_job/services/feathers/accounting/accounting.dart';

class AccountingScreen extends StatelessWidget {
  const AccountingScreen({super.key});
  static String route() => "/accounting";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountingBloc, AccountingState>(
      builder: (context, state) {
        switch (state.status) {
          case EnumAccountingState.initial:
            return const Loader();
          case EnumAccountingState.error:
            return const InitTextWidget(
              text: "error . . .",
            );
          case EnumAccountingState.loaded:
            return DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    "Accounting",
                  ),
                  centerTitle: true,
                  // actions: const [
                  //   AppBarDropdownWidget(),
                  // ],
                  bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(40),
                    child: TabBar(
                      indicatorColor: Colors.green,
                      indicatorWeight: 3,
                      // indicatorSize: TabBarIndicatorSize.tab,
                      // indicator: BoxDecoration(
                      //   color: Colors.green,
                      //   borderRadius: BorderRadius.circular(8),
                      // ),
                      tabs: [
                        Icon(Icons.pie_chart),
                        Icon(Icons.list),
                        Icon(Icons.bar_chart),
                        Icon(Icons.settings),
                      ],
                    ),
                  ),
                ),
                body: const TabBarView(
                  children: [
                    AccountingPieWidget(),
                    AccountingListseWidget(),
                    AccountingBarWidget(),
                    AccountingSettingWidget(),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}

// class AccountingScreen extends StatefulWidget {
//   const AccountingScreen({super.key});

//   static String route() => "/accounting";

//   @override
//   State<AccountingScreen> createState() => _AccountingScreenState();
// }

// class _AccountingScreenState extends State<AccountingScreen> {
//   int _currentIndex = 0;
//   final screens = <Widget>[
//     AccountingPieWidget(),
//     const AccountingListseWidget(),
//     const AccountingBarWidget(),
//     const AccountingSettingWidget(),
//   ];
//   final names = <String>[
//     "Overview",
//     "Detail",
//     "Weekly Expense",
//     "Setting",
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AccountingBloc, AccountingState>(
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Text(names[_currentIndex]),
//             centerTitle: true,
//           ),
//           body: screens[_currentIndex],
//           bottomNavigationBar: NavigationBar(
//             selectedIndex: _currentIndex,
//             indicatorColor: Colors.green,
//             destinations: const [
//               NavigationDestination(
//                 icon: Icon(Icons.pie_chart),
//                 label: "view",
//               ),
//               NavigationDestination(
//                 icon: Icon(Icons.list),
//                 label: "detail",
//               ),
//               NavigationDestination(
//                 icon: Icon(Icons.bar_chart),
//                 label: "weekly",
//               ),
//               NavigationDestination(
//                 icon: Icon(Icons.settings),
//                 label: "setting",
//               ),
//             ],
//             onDestinationSelected: (value) {
//               setState(() {
//                 _currentIndex = value;
//               });
//             },
//           ),
//         );
//       },
//     );
//   }
// }
