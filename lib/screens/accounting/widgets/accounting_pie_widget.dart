// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:random_job/screens/accounting/components/components.dart';

class AccountingPieWidget extends StatelessWidget {
  const AccountingPieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AccountingCreateComponent(),
    );
  }
}
