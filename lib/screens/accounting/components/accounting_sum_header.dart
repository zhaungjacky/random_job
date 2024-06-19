import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:random_job/services/feathers/accounting/accounting.dart';
import 'package:random_job/services/utils/utils.dart';

class AccountingSumZone extends StatelessWidget {
  const AccountingSumZone({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = WidthProvider.setWidthAndHeight(context)["width"];
    return Container(
      width: width,
      padding: const EdgeInsets.only(
        top: 8,
        left: 16,
        right: 16,
        bottom: 8,
      ),
      // margin: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: BlocBuilder<AccountingBloc, AccountingState>(
          builder: (context, state) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Text(
                      "In:",
                      style: TextStyle(color: Colors.green),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      state.incoming.toStringAsFixed(2),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    const Text(
                      "Out:",
                      style: TextStyle(color: Colors.red),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      state.expense.toStringAsFixed(2),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    const Text(
                      "Total:",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      ((state.incoming) - (state.expense)).toStringAsFixed(2),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
