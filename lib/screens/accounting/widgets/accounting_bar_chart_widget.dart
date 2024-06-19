// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:random_job/screens/accounting/utils/utils.dart';
import 'package:random_job/screens/screens.dart';
import 'package:random_job/services/feathers/accounting/accounting.dart';

class AccountingBarChartWidget extends StatefulWidget {
  const AccountingBarChartWidget({
    super.key,
    required this.lists,
    required this.type,
  });
  final List<AccountingModel> lists;
  final AccountingInOrOutType type;
  @override
  State<StatefulWidget> createState() => AccountingBarChartWidgetState();
}

class AccountingBarChartWidgetState extends State<AccountingBarChartWidget> {
  @override
  Widget build(BuildContext context) {
    final List<double> dataSources = [0, 0, 0, 0, 0, 0, 0];
    // final List<double> inDatas = [0, 0, 0, 0, 0, 0, 0];
    for (final list in widget.lists) {
      final DateTime day = list.date!.toDate();
      final weekDay = day.weekday;
      // print(weekDay);
      // print(ist.date!.toDate());
      final bool isCurrentWeek = IsCurrentWeek.isCurrentWeek(day);
      // print("$day and $isCurrentWeek");
      // print(day);
      if (!isCurrentWeek) {
        continue;
      }
      if (list.type == AccountingInOrOutType.outgoing.name &&
          widget.type.name == AccountingInOrOutType.outgoing.name) {
        dataSources[weekDay - 1] += list.amount!;
      } else if (list.type == AccountingInOrOutType.incoming.name &&
          widget.type.name == AccountingInOrOutType.incoming.name) {
        dataSources[weekDay - 1] += list.amount!;
      }
    }

    // print("bar_chat_data: $dataSources");
    // print(inDatas);

    return AspectRatio(
      aspectRatio: 1.2,
      child: _BarChart(
        dataSources: dataSources,
      ),
    );
  }
}

class _BarChart extends StatelessWidget {
  _BarChart({
    required this.dataSources,
  });
  final List<double> dataSources;
  int index = -1;

  double maxData = 0;

  @override
  Widget build(BuildContext context) {
    for (final data in dataSources) {
      maxData = maxData > data ? maxData : data;
    }
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: maxData * 1.3,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: AppColors.contentColorCyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.contentColorBlue,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mn';
        break;
      case 1:
        text = 'Te';
        break;
      case 2:
        text = 'Wd';
        break;
      case 3:
        text = 'Tu';
        break;
      case 4:
        text = 'Fr';
        break;
      case 5:
        text = 'St';
        break;
      case 6:
        text = 'Sn';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          AppColors.contentColorBlue,
          AppColors.contentColorCyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  //!data here
  List<BarChartGroupData> get barGroups => dataSources.map((e) {
        index++;

        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: e,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        );
      }).toList();
  // [
  //       BarChartGroupData(
  //         x: 0,
  //         barRods: [
  //           BarChartRodData(
  //             toY: 8,
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 1,
  //         barRods: [
  //           BarChartRodData(
  //             toY: 10,
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 2,
  //         barRods: [
  //           BarChartRodData(
  //             toY: 14,
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 3,
  //         barRods: [
  //           BarChartRodData(
  //             toY: 15,
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 4,
  //         barRods: [
  //           BarChartRodData(
  //             toY: 13,
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 5,
  //         barRods: [
  //           BarChartRodData(
  //             toY: 10,
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //       BarChartGroupData(
  //         x: 6,
  //         barRods: [
  //           BarChartRodData(
  //             toY: 16,
  //             gradient: _barsGradient,
  //           )
  //         ],
  //         showingTooltipIndicators: [0],
  //       ),
  //     ];
}
