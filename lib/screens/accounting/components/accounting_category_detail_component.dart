import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:random_job/screens/accounting/utils/utils.dart';
import 'package:random_job/services/services.dart';

class AccountingCategoryDetailComponent extends StatelessWidget {
  const AccountingCategoryDetailComponent(
      {super.key, required this.lists, required this.categoryIndex});
  final List<AccountingModel> lists;
  final int categoryIndex;

  @override
  Widget build(BuildContext context) {
    final width = WidthProvider.setWidthAndHeight(context)["width"]!;
    final height = WidthProvider.setWidthAndHeight(context)["height"]!;
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            SizedBox(
              // color: Colors.red,
              width: width,
              height: height * 0.2,
              child: SvgPicture.asset(
                ColorsAndSvgs.mySvg[categoryIndex],
              ),
            ),
            const Gap(20),
            Expanded(
              child: ListView.builder(
                itemCount: lists.length,
                itemBuilder: (context, index) {
                  final list = lists[index];
                  return Card(
                    child: ListTile(
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        DateFormat.yMMMM().format(
                          list.createdAt!.toDate(),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        list.context!,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      trailing: Text(
                        list.amount.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
