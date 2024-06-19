part of 'accounting_category_bloc.dart';

@immutable
sealed class AccountingCategoryEvent {
  const AccountingCategoryEvent();
}

// final class LoadingAccountingCategoryEvent extends AccountingCategoryEvent {}

final class LoadingAccountingCategoryEvent extends AccountingCategoryEvent {
  final List<AccountingModel> lists;

  const LoadingAccountingCategoryEvent(this.lists);
}

final class ErrorAccountingCategoryEvent extends AccountingCategoryEvent {
  final String message;

  const ErrorAccountingCategoryEvent(this.message);
}
