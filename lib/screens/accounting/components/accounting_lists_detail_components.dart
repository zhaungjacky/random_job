// ignore_for_file: use_build_context_synchronously

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_job/screens/accounting/utils/utils.dart';
import 'package:random_job/screens/accounting/widgets/widgets.dart';
import 'package:random_job/screens/widgets/widgets.dart';
import 'package:random_job/services/feathers/accounting/repository/accounting_repository.dart';
import 'package:random_job/services/services.dart';

class AccountingListsDetailComponent extends StatefulWidget {
  const AccountingListsDetailComponent({
    super.key,
    required this.lists,
  });

  final List<AccountingModel> lists;

  @override
  State<AccountingListsDetailComponent> createState() =>
      _AccountingListsDetailComponentState();
}

class _AccountingListsDetailComponentState
    extends State<AccountingListsDetailComponent> {
  final SingleValueDropDownController categoryController =
      SingleValueDropDownController();

  final SingleValueDropDownController typeController =
      SingleValueDropDownController();

  final TextEditingController amountController = TextEditingController();

  final TextEditingController contextController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  final accountingService = singleton<AccountingRepository>();

  @override
  void dispose() {
    super.dispose();
    categoryController.dispose();
    typeController.dispose();
    amountController.dispose();
    contextController.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = widget.lists.map((accounting) {
      final icon = accounting.type == AccountingInOrOutType.outgoing.name
          ? const Icon(
              Icons.arrow_circle_up,
              size: 24,
              color: Colors.red,
            )
          : const Icon(
              Icons.arrow_circle_down,
              size: 24,
              color: Colors.green,
            );
      return Container(
        margin: const EdgeInsets.only(top: 6, left: 6, right: 6),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Dismissible(
          key: Key(accounting.id!),
          direction: DismissDirection.endToStart,
          confirmDismiss: (_) async {
            final res = await handleBool(context);
            if (!res) return;
            await accountingService.deleteItem(accounting.id!);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Delete record success',
                  style: TextStyle(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            );
            return null;
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: _listTile(
              context: context,
              icon: icon,
              list: accounting,
              categoryController: categoryController,
              typeController: typeController,
              amountController: amountController,
              contextController: contextController,
            ),
          ),
        ),
      );
    }).toList();

    return Column(
      children: [
        Flexible(
          child: ListView(
            controller: scrollController,
            reverse: true,
            shrinkWrap: true,
            children: UnmodifiableListView(messages),
          ),
        ),
      ],
    );
  }

  Widget _listTile({
    required BuildContext context,
    required Icon icon,
    required AccountingModel list,
    required SingleValueDropDownController categoryController,
    required SingleValueDropDownController typeController,
    required TextEditingController amountController,
    required TextEditingController contextController,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 0,
      ),
      child: ListTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        leading: icon,
        title: Text(list.category!),
        subtitle: Row(
          children: [
            const Icon(
              Icons.monetization_on_outlined,
              size: 16,
            ),
            const SizedBox(
              width: 6,
            ),
            Text(list.amount!.toStringAsFixed(2)),
          ],
        ),
        trailing: Text(
          DateFormat.yMMMMd().format(list.date!.toDate()),
          style: const TextStyle(fontSize: 10),
        ),

        //modify record
        onTap: () async {
          categoryController.dropDownValue = DropDownValueModel(
            name: list.category!,
            value: list.category!,
          );
          typeController.dropDownValue = DropDownValueModel(
            name: list.type!,
            value: list.type!,
          );
          amountController.text = list.amount.toString();
          contextController.text = list.context!;
          final obj = await handleAccountingRecordDialog(
            context,
            AccountingCategoryType.values,
            AccountingInOrOutType.values,
            categoryController,
            typeController,
            amountController,
            contextController,
            "Edit record",
          );

          if (obj == null) {
            categoryController.clearDropDown();
            typeController.clearDropDown();
            amountController.clear();
            contextController.clear();
            return;
          }

          final date = await handlePickDateDialog(context, list.date!.toDate());

          if (date == null) return;

          final newAccounting = AccountingModel(
            category: obj['category'],
            type: obj['type'],
            amount: obj['amount'],
            context: obj['context'],
            date: Timestamp.fromDate(date),
            createdAt: Timestamp.now(),
            userId: accountingService.userId,
            id: null,
          );

          await accountingService.updateItem(list.id!, newAccounting);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Update record success',
                style: TextStyle(
                  fontSize: 22,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          );

          categoryController.clearDropDown();
          typeController.clearDropDown();
          amountController.clear();
          contextController.clear();
        },
      ),
    );
  }
}
