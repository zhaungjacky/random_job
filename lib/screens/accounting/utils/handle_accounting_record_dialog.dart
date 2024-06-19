import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:random_job/screens/accounting/utils/utils.dart';
import 'package:random_job/screens/widgets/widgets.dart';
import 'package:random_job/services/feathers/accounting/accounting.dart';

Future<Map<String, dynamic>?> handleAccountingRecordDialog(
  BuildContext context,
  List<AccountingCategoryType> categoryTypes,
  List<AccountingInOrOutType> types,
  SingleValueDropDownController categoryController,
  SingleValueDropDownController typeController,
  TextEditingController amountController,
  TextEditingController contextController, [
  String? title,
]) {
  return showDialog(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: AlertDialog(
          title: Text(
            title ?? "Add record",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          content: Column(
            children: [
              // in or out
              DropdownTextFieldDetail<AccountingInOrOutType>(
                lists: types,
                categoryController: categoryController,
                typeController: typeController,
              ),
              const SizedBox(
                height: 10,
              ),
              // category
              DropdownTextFieldDetail<AccountingCategoryType>(
                lists: categoryTypes,
                categoryController: categoryController,
                typeController: typeController,
              ),

              const SizedBox(
                height: 10,
              ),

              TextField(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                controller: amountController,
                decoration: const InputDecoration(
                  hintText: "Amount ...",
                  prefixIcon: Icon(
                    Icons.monetization_on,
                    color: Colors.redAccent,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                controller: contextController,
                decoration: const InputDecoration(
                  hintText: "Detail...",
                  prefixIcon: Icon(
                    Icons.note_add,
                    color: Colors.green,
                  ),
                ),
                // keyboardType: TextInputType.,
                // maxLines: 2,
              ),
            ],
          ),
          actions: [
            MyMaterialButton(
              //cancel
              onPressed: () {
                if (amountController.text.trim().isNotEmpty &&
                    categoryController.dropDownValue?.value != null &&
                    typeController.dropDownValue?.value != null &&
                    contextController.text.trim().isNotEmpty) {
                  Navigator.of(context).pop(
                    {
                      'category':
                          categoryController.dropDownValue!.value as String,
                      'type': typeController.dropDownValue!.value as String,
                      'amount': double.parse(amountController.text),
                      'context': contextController.text,
                    },
                  );
                } else {
                  Navigator.of(context).pop(null);
                }
              },
              icon: const Icon(
                Icons.next_plan_outlined,
                color: Colors.green,
                size: 32,
              ),
            ),
            MyMaterialButton(
              //cancel
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 32,
              ),
            ),
          ],
        ),
      );
    },
  );
}
