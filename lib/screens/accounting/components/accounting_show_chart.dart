import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:random_job/screens/accounting/components/components.dart';
import 'package:random_job/screens/widgets/widgets.dart';
import 'package:random_job/services/feathers/accounting/accounting.dart';

// show 90 days in and out sum monthly

class AccountingShowChart extends StatelessWidget {
  const AccountingShowChart({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountingBloc, AccountingState>(
        builder: (context, state) {
      if (state.chartDataBar.keys.isEmpty || state.chartDataPie.keys.isEmpty) {
        return const InitTextWidget(
          text: "Ops no data . . .",
        );
      }

      final showBarChart = state.showBarChart;
      final data = showBarChart
          ? state.chartDataBar
          : state.chartDataPie as Map<dynamic, double>;
      final text = showBarChart
          ? "${DateFormat("M/dd").format(state.endAt!.toDate())} to ${DateFormat("M/dd").format(state.startAt!.toDate())}  in and out sum"
          : "${DateFormat("M/dd").format(state.endAt!.toDate())} to ${DateFormat("M/dd").format(state.startAt!.toDate())}  only out details";
      return Align(
        alignment: Alignment.center,
        child: AccountingChartPieOrChart(
          chartData: data,
          title: text,
        ),
      );
    });
  }
}


/*
class AccountingShowChart extends StatefulWidget {
  const AccountingShowChart({
    super.key,
    required this.chartDataBar,
    required this.chartDataPie,
  });

  final Map<AccountingInOrOutType, double> chartDataBar;
  final Map<AccountingCategoryType, double> chartDataPie;

  @override
  State<AccountingShowChart> createState() => _AccountingShowChartState();
}

class _AccountingShowChartState extends State<AccountingShowChart> {
  bool showBar = true;
  Map<dynamic, double> data = {};
  String title = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      data = showBar ? widget.chartDataBar : widget.chartDataPie;
      title = showBar ? "90 days in and out" : "90 days  out detail";
    });
  }

  void toggleChart() {
    showBar = !showBar;
    setState(() {
      data = showBar ? widget.chartDataBar : widget.chartDataPie;
      title = showBar ? "90 days in and out" : "90 days  out detail";
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
            ),
            child: CupertinoSwitch(
              value: showBar,
              onChanged: (_) {
                toggleChart();
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: AccountingChartPieOrChart(
            chartData: data,
            title: title,
          ),
        ),
      ],
    );
  }
}

*/
