import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:random_job/screens/accounting/utils/utils.dart';
import 'package:random_job/screens/screens.dart';
import 'package:random_job/services/feathers/accounting/model/accounting_category_type.dart';

class AccountingCreateCardComponent extends StatelessWidget {
  const AccountingCreateCardComponent({
    super.key,
    required this.chartDataPie,
  });

  final Map<AccountingCategoryType, double> chartDataPie;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chartDataPie.entries
            .map(
              (e) => SizedBox(
                width: 120,
                height: 160,
                // color: Colors.amberAccent,
                child: GestureDetector(
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Gap(10),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: SvgPicture.asset(
                            ColorsAndSvgs.mySvg[e.key.index],
                          ),
                        ),
                        const Gap(10),
                        Text(
                          e.key.name,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const Gap(10),
                        Text(
                          e.value.toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    context.push(
                      AccountingCategoryDetailScreen.route(e.key.name),
                    );
                  },
                ),
              ),
            )
            .toList(),
      ),
      // Row(
      //   children:
      //       // state.chartDataPie.keys.map((key) {
      //       //   return Card(
      //       //     child: ListTile(
      //       //       title: Text(key.name),
      //       //     ),
      //       //   );
      //       // }).toList(),

      //       [
      //     Container(
      //       color: Colors.tealAccent,
      //       width: 120,
      //       height: 160,
      //       child: const Card(
      //         child: Text("hello"),
      //       ),
      //     ),
      //     Container(
      //       color: Colors.tealAccent,
      //       width: 120,
      //       height: 160,
      //       child: const Card(
      //         child: Text("hello"),
      //       ),
      //     ),
      //     Container(
      //       color: Colors.tealAccent,
      //       width: 120,
      //       height: 160,
      //       child: const Card(
      //         child: Text("hello"),
      //       ),
      //     ),
      //     Container(
      //       color: Colors.tealAccent,
      //       width: 120,
      //       height: 160,
      //       child: const Card(
      //         child: Text("hello"),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
