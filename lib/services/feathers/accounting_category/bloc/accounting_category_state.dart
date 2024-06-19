part of 'accounting_category_bloc.dart';

@immutable
sealed class AccountingCategoryState {
  const AccountingCategoryState();
}

final class LoadingAccountingCategoryState extends AccountingCategoryState {}

final class LoadedAccountingCategoryState extends AccountingCategoryState {
  final List<AccountingModel> lists;

  const LoadedAccountingCategoryState(this.lists);
}

final class ErrorAccountingCategoryState extends AccountingCategoryState {
  final String message;

  const ErrorAccountingCategoryState(this.message);
}
