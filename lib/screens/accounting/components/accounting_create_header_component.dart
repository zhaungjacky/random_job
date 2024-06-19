import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AccountingCreateHeaderComponent extends StatelessWidget {
  const AccountingCreateHeaderComponent({
    super.key,
    required this.width,
    required this.height,
    required this.incoming,
    required this.expense,
  });

  final double width;
  final double height;
  final double incoming;
  final double expense;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        // color: Colors.lightBlue,
        // width: width,
        // height: height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //incoming
            Column(
              children: [
                const Text(
                  "In",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.green,
                  ),
                ),
                const Gap(10),
                Text(
                  "\$ ${incoming.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Gap(20),
            //incoming
            Column(
              children: [
                const Text(
                  "Out",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.red,
                  ),
                ),
                const Gap(10),
                Text(
                  "\$ ${expense.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Gap(20),
            //incoming
            Column(
              children: [
                const Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.blue,
                  ),
                ),
                const Gap(10),
                Text(
                  "\$ ${(incoming - expense).toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
