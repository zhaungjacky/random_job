part of 'accounting_bloc.dart';

class AccountingEvent extends Equatable {
  const AccountingEvent();

  @override
  List<Object?> get props => [];
}

class InitAccountingEvent extends AccountingEvent {}

class LoadAccountingEvent extends AccountingEvent {
  final List<AccountingModel> lists;
  const LoadAccountingEvent({required this.lists});
  @override
  List<Object?> get props => [lists];
}

class ToggleIsShowChartEvent extends AccountingEvent {}

class ToggleBarOrPieEvent extends AccountingEvent {}

class UpdateNewStartEndDateEvent extends AccountingEvent {
  final Timestamp startAt;
  final Timestamp endAt;

  const UpdateNewStartEndDateEvent({
    required this.startAt,
    required this.endAt,
  });
  @override
  List<Object?> get props => [startAt, endAt];
}

class ResetStartEndDateEvent extends AccountingEvent {}

// class AddAccountingEvent extends AccountingEvent {
//   final AccountingModel accounting;

//   const AddAccountingEvent({required this.accounting});
//   @override
//   List<Object?> get props => [accounting];
// }

// class DeleteAccountingEvent extends AccountingEvent {
//   final String accountingId;

//   const DeleteAccountingEvent({required this.accountingId});
//   @override
//   List<Object?> get props => [accountingId];
// }

// class UpdateAccountingEvent extends AccountingEvent {
//   final String accountingId;
//   final AccountingModel accounting;
//   const UpdateAccountingEvent(
//       {required this.accountingId, required this.accounting});
//   @override
//   List<Object?> get props => [accountingId, accounting];
// }


