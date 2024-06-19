// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:random_job/screens/accounting/utils/handle_accounting_record_dialog.dart';
import 'package:random_job/screens/accounting/widgets/widgets.dart';
import 'package:random_job/services/feathers/accounting/repository/accounting_repository.dart';
import 'package:random_job/services/services.dart';

Future<void> addAccounting(
  BuildContext context,
  String userId,
  SingleValueDropDownController categoryController,
  SingleValueDropDownController typeController,
  TextEditingController amountController,
  TextEditingController contextController,
) async {
  // if (textController.text.isEmpty) return;

  final Map<String, dynamic>? obj = await handleAccountingRecordDialog(
    context,
    AccountingCategoryType.values,
    AccountingInOrOutType.values,
    categoryController,
    typeController,
    amountController,
    contextController,
    "Add record",
  );

  if (obj == null) return;

  final DateTime? date = await handlePickDateDialog(
    context,
  );
  if (date == null) return;

  final newAccounting = AccountingModel(
    category: obj['category'],
    type: obj['type'],
    amount: obj['amount'],
    context: obj['context'],
    date: Timestamp.fromDate(date),
    createdAt: Timestamp.now(),
    userId: userId,
    id: null,
  );

  await singleton<AccountingRepository>().addItem(newAccounting);
  categoryController.clearDropDown();
  typeController.clearDropDown();
  amountController.clear();
  contextController.clear();
}
