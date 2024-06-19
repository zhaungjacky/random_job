// ignore_for_file: use_build_context_synchronously

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_job/screens/accounting/components/components.dart';
import 'package:random_job/screens/accounting/utils/utils.dart';
import 'package:random_job/screens/widgets/widgets.dart';
import 'package:random_job/services/feathers/accounting/repository/accounting_repository.dart';
import 'package:random_job/services/services.dart';

class AccountingListseWidget extends StatefulWidget {
  const AccountingListseWidget({super.key});

  @override
  State<AccountingListseWidget> createState() => _AccountingListseWidgetState();
}

class _AccountingListseWidgetState extends State<AccountingListseWidget> {
  final SingleValueDropDownController categoryController =
      SingleValueDropDownController();

  final SingleValueDropDownController typeController =
      SingleValueDropDownController();

  final TextEditingController amountController = TextEditingController();

  final TextEditingController contextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    categoryController.dispose();
    typeController.dispose();
    amountController.dispose();
    contextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountingBloc, AccountingState>(
      builder: (context, state) {
        final lists = state.lists;

        if (state.status == EnumAccountingState.error) {
          return const InitTextWidget(
            text: "error . . .",
          );
        } else if (state.status == EnumAccountingState.initial) {
          return const Loader();
        } else {
          return Scaffold(
            body: SizedBox(
              // color: Colors.lightBlueAccent,
              // width: WidthProvider.setWidthAndHeight(context)["width"],
              height: WidthProvider.setWidthAndHeight(context)["height"]! * 0.8,
              child: lists.isEmpty
                  ? const InitTextWidget(
                      text: "no record . . .",
                    )
                  : AccountingListsDetailComponent(
                      lists: lists,
                    ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await addAccounting(
                  context,
                  singleton<AccountingRepository>().userId!,
                  categoryController,
                  typeController,
                  amountController,
                  contextController,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Add record success',
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        }
      },
    );
  }
}
