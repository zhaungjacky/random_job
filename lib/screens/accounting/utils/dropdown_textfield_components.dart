import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:random_job/services/feathers/accounting/accounting.dart';

class DropdownTextFieldDetail<T> extends StatelessWidget {
  final List<T> lists;
  final SingleValueDropDownController categoryController;
  final SingleValueDropDownController typeController;
  const DropdownTextFieldDetail({
    super.key,
    required this.lists,
    required this.categoryController,
    required this.typeController,
  });
  @override
  Widget build(BuildContext context) {
    // print(identical(T, AccountingCategoryType));
    if (identical(T, AccountingCategoryType)) {
      return DropDownTextField(
        textStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        listTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        controller: categoryController,
        textFieldDecoration: const InputDecoration(
          hintText: "Category...",
          prefixIcon: Icon(
            Icons.menu,
            color: Colors.blue,
          ),
        ),
        validator: (value) {
          if (value == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        // initialValue: provider.categoryController.dropDownValue,
        enableSearch: true,

        dropDownList: lists.map(
          (e) {
            final val = e as AccountingCategoryType;
            return DropDownValueModel(name: val.name, value: val.name);
          },
        ).toList(),
      );
    } else if (identical(T, AccountingInOrOutType)) {
      return DropDownTextField(
        controller: typeController,
        textStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        listTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        textFieldDecoration: const InputDecoration(
          hintText: "In or out...",
          prefixIcon: Icon(
            Icons.type_specimen,
            color: Colors.blueGrey,
          ),
        ),
        // initialValue: provider.typeController.dropDownValue,
        validator: (value) {
          if (value == null) {
            return "Required field";
          } else {
            return null;
          }
        },
        dropDownList: lists.map(
          (e) {
            final val = e as AccountingInOrOutType;
            return DropDownValueModel(name: val.name, value: val.name);
          },
        ).toList(),
      );
    } else {
      return const Text("Not working...");
    }
  }
}
