import 'package:flutter/material.dart';
import 'package:random_job/services/utils/utils.dart';

Future<DateTime?> handlePickDateDialog(
  BuildContext context, [
  DateTime? initialDate,
  String? title,
]) {
  return showDialog(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: AlertDialog(
          title: Text(
            title ?? "Select Date",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          content: SizedBox(
            height: WidthProvider.setWidthAndHeight(
                    context)[WidthProvider.heightStr]! *
                0.7,
            width: WidthProvider.setWidthAndHeight(
                    context)[WidthProvider.widthStr]! *
                0.7,
            child: DatePickerDialog(
              initialDate: initialDate ?? DateTime.now(),
              firstDate: DateProvider.dateStartDistant(),
              lastDate: DateProvider.dateEndDistant(),
              // firstDate: ref.read(myAccountingProvider.notifier).start,
              // lastDate: ref.read(myAccountingProvider.notifier).end,
            ),
          ),
          // actions: [
          //   MyTextButton(
          //     text: "Confirm",
          //     color: Colors.green,
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          //   MyTextButton(
          //     text: "Cancel",
          //     color: Colors.red,
          //     onPressed: () {
          //       Navigator.of(context).pop(null);
          //     },
          //   ),
          // ],
        ),
      );
    },
  );
}
