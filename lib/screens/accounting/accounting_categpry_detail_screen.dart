import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_job/screens/accounting/components/components.dart';
import 'package:random_job/screens/widgets/widgets.dart';
import 'package:random_job/services/services.dart';

class AccountingCategoryDetailScreen extends StatelessWidget {
  const AccountingCategoryDetailScreen({
    super.key,
    required this.accountingcategoryType,
  });
  final AccountingCategoryType accountingcategoryType;

  static String route([String? categoryType]) =>
      "/accounting/${categoryType ?? ':categoryType'}";

  @override
  Widget build(BuildContext context) {
    final categoryType = accountingcategoryType.name;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryType),
        centerTitle: true,
      ),
      body: BlocProvider<AccountingCategoryBloc>(
        create: (context) => AccountingCategoryBloc(
          accountingCategoryRepository:
              singleton<AccountingCategoryRepository>(),
          key: "category",
          value: categoryType,
        ),
        child: BlocBuilder<AccountingCategoryBloc, AccountingCategoryState>(
          builder: (context, state) {
            switch (state) {
              case LoadingAccountingCategoryState():
                return const Loader();
              case ErrorAccountingCategoryState():
                return InitTextWidget(
                  text: state.message,
                );
              case LoadedAccountingCategoryState():
                // final lists = state.lists;
                return AccountingCategoryDetailComponent(
                  lists: state.lists,
                  categoryIndex: accountingcategoryType.index,
                );
            }
          },
        ),
      ),
    );
  }
}
