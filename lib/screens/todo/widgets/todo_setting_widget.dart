// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:random_job/screens/accounting/widgets/widgets.dart';

import 'package:random_job/screens/widgets/widgets.dart';

import 'package:random_job/services/services.dart';

class TodoSettingWidget extends StatelessWidget {
  const TodoSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = WidthProvider.setWidthAndHeight(context)['height']!;
    final width = WidthProvider.setWidthAndHeight(context)['width']!;
    return Scaffold(
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoSuccessState) {
            final String startDay = DateFormat.MMMMd().format(
              state.startAt!.toDate(),
            );
            final String endDay = DateFormat.MMMMd().format(
              state.endAt!.toDate(),
            );

            final String title = "$endDay to $startDay";
            return Center(
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
                      context.read<TodoBloc>().add(
                            UpdateTodoDateEvent(
                              startAt: Timestamp.fromDate(startAt),
                              endAt: Timestamp.fromDate(endAt),
                            ),
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
                      context.read<TodoBloc>().add(
                            ResetTodoDateEvent(),
                          );
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
            );
          } else {
            return const Loader();
          }
        },
      ),
    );
  }
}
