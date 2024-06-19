// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:random_job/screens/accounting/widgets/widgets.dart';
import 'package:random_job/screens/widgets/widgets.dart';
import 'package:random_job/services/services.dart';

class ChatSettingWidget extends StatelessWidget {
  const ChatSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = WidthProvider.setWidthAndHeight(context)['height']!;
    final width = WidthProvider.setWidthAndHeight(context)['width']!;
    final chatRepository = singleton<ChatRepository>();
    final String startDay = DateFormat.MMMMd().format(
      chatRepository.startAt.toDate(),
    );
    final String endDay = DateFormat.MMMMd().format(
      chatRepository.endAt.toDate(),
    );

    final String title = "$endDay to $startDay";
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Gap(10),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Gap(10),

            //select date
            DateSettingGestureDetector(
              width: width,
              height: height * 0.33,
              onTap: () async {
                final DateTime? startAt = await handlePickDateDialog(
                  context,
                  null,
                  "Start date",
                );
                if (startAt == null) return;
                final DateTime? endAt = await handlePickDateDialog(
                  context,
                  null,
                  "End date",
                );
                if (endAt == null) return;

                chatRepository.updateStartAndEndDate(
                  newStartAt: Timestamp.fromDate(startAt),
                  newEndAt: Timestamp.fromDate(endAt),
                );
              },
              icon: Icon(
                Icons.calendar_month,
                size: width / 2,
                color: Colors.red,
              ),
              color: Colors.teal.shade300,
              title: 'select date',
            ),
            const Gap(20),

            //reset date
            DateSettingGestureDetector(
              width: width,
              height: height * 0.33,
              onTap: () async {
                final bool res = await handleBool(
                  context,
                  "Reset date",
                );
                if (!res) return;
                chatRepository.resetStartAndEndDate();
              },
              icon: Icon(
                Icons.refresh,
                size: width / 2,
                color: Colors.green.shade700,
              ),
              color: Colors.orangeAccent,
              title: 'reset date',
            ),
          ],
        ),
      ),
    );
  }
}
