import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:random_job/screens/accounting/widgets/accounting_bar_chart_widget.dart';
import 'package:random_job/services/services.dart';

class AccountingBarWidget extends StatelessWidget {
  const AccountingBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final width = WidthProvider.setWidthAndHeight(context)["width"]!;
    final height = WidthProvider.setWidthAndHeight(context)["height"]!;
    final now = DateTime.now();
    final String mondayDay = DateFormat.MMMMd().format(
      now.subtract(
        Duration(days: now.weekday - DateTime.monday),
      ),
    );
    final String sundayDay = DateFormat.MMMMd().format(
      now.add(
        Duration(days: DateTime.sunday - now.weekday),
      ),
    );
    return BlocBuilder<AccountingBloc, AccountingState>(
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                right: 16,
                left: 16,
                bottom: 8.0,
              ),
              child: Column(
                children: [
                  Text(
                    "Out  -> from  $mondayDay  to  $sundayDay",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(
                    // color: Colors.tealAccent,
                    height: height * 0.3,
                    child: AccountingBarChartWidget(
                      lists: state.lists,
                      type: AccountingInOrOutType.outgoing,
                    ),
                  ),
                  const Gap(30),
                  Text(
                    "In  -> from $mondayDay  to  $sundayDay",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(
                    // color: Colors.tealAccent,
                    height: height * 0.3,
                    child: AccountingBarChartWidget(
                      lists: state.lists,
                      type: AccountingInOrOutType.incoming,
                    ),
                  ),
                  const Gap(30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
