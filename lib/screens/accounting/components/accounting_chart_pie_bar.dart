import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:random_job/screens/accounting/utils/utils.dart';
import 'package:random_job/services/feathers/accounting/accounting.dart';

class AccountingChartPieOrChart<T> extends StatefulWidget {
  const AccountingChartPieOrChart({
    super.key,
    required this.chartData,
    required this.title,
  });

  final Map<T, double> chartData;
  final String title;

  @override
  State<AccountingChartPieOrChart> createState() =>
      _AccountingChartPieOrChartState();
}

class _AccountingChartPieOrChartState extends State<AccountingChartPieOrChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: 0.1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(
                          () {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            final newIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                            touchedIndex = newIndex;
                            // print(newIndex);
                          },
                        );
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 20,
                    sections: showingSections(
                      widget.chartData.keys.first,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: widget.chartData.keys.map(
                  (value) {
                    String name;
                    if (value is AccountingCategoryType) {
                      name = value.name;
                    } else if (value is AccountingInOrOutType) {
                      name = value.name;
                    } else {
                      name = "oh no";
                    }
                    return Column(
                      children: [
                        Indicator(
                          color: ColorsAndSvgs.myColors[value.index],
                          text: name,
                          isSquare: true,
                          textColor: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(dynamic t) {
    int sectionIndex = -1;

    return widget.chartData.entries.map(
      (obj) {
        sectionIndex++;

        final isTouched = sectionIndex == touchedIndex;
        final fontSize = isTouched ? 20.0 : 16.0;
        final radius = isTouched ? 110.0 : 100.0;
        final widgetSize = isTouched ? 55.0 : 40.0;
        const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
        List<String> list = [];
        if (t is AccountingCategoryType) {
          list = ColorsAndSvgs.mySvg;
        } else if (t is AccountingInOrOutType) {
          list = ColorsAndSvgs.myInOrOutSvg;
        } else {
          list = [];
        }
        return PieChartSectionData(
          color: ColorsAndSvgs.myColors[obj.key.index],
          value: obj.value,
          title: obj.value.toString(),
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
            shadows: shadows,
          ),
          badgeWidget: _Badge(
            list[obj.key.index],
            size: widgetSize,
            borderColor: ColorsAndSvgs.myColors[obj.key.index],
          ),
          badgePositionPercentageOffset: .98,
        );
      },
    ).toList();
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgAsset, {
    required this.size,
    required this.borderColor,
  });
  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: SvgPicture.asset(
          svgAsset,
        ),
      ),
    );
  }
}
