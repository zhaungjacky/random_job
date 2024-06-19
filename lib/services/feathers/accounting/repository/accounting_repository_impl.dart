import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_job/services/feathers/accounting/accounting.dart';
import 'package:random_job/services/feathers/accounting/repository/accounting_repository.dart';

class AccountingRepositoryImpl implements AccountingRepository {
  final AccountingDataSource accountingDataSource;

  const AccountingRepositoryImpl(this.accountingDataSource);

  static String mainCollection() => "accountings";
  static String secondaryCollection() => "accounting";
  static bool isAccountingStreamDescending() => true;
  // static String route() => "/accounting";

  @override
  Future<void> addItem(AccountingModel accounting) async {
    await accountingDataSource.addItem(accounting);
  }

  @override
  Map<String, double> calculateMonthAmmount({
    required List<AccountingModel> lists,
  }) {
    return accountingDataSource.calculateMonthAmmount(
      lists: lists,
    );
  }

  @override
  Future<void> deleteItem(String id) async {
    await accountingDataSource.deleteItem(id);
  }

  @override
  Timestamp get endAt => accountingDataSource.endAt;

  @override
  Map<AccountingInOrOutType, double>? getChartDataInAndOut(
      List<AccountingModel> lists) {
    return accountingDataSource.getChartDataInAndOut(lists);
  }

  @override
  Map<AccountingCategoryType, double>? getChartDataOutgoing(
      List<AccountingModel> lists) {
    return getChartDataOutgoing(lists);
  }

  @override
  Stream<QuerySnapshot> getItems({
    required String mainCollection,
    required String? uid,
    required String secondaryCollection,
    required bool isDescending,
    required Timestamp startAt,
    required Timestamp endAt,
  }) {
    return accountingDataSource.getItems(
      mainCollection: mainCollection,
      uid: uid,
      secondaryCollection: secondaryCollection,
      isDescending: isDescending,
      startAt: startAt,
      endAt: endAt,
    );
  }

  @override
  resetStartAndEndDate() {
    accountingDataSource.resetStartAndEndDate();
  }

  @override
  Timestamp get startAt => accountingDataSource.startAt;

  @override
  Future<void> updateItem(
    String accountingId,
    AccountingModel accounting,
  ) async {
    return await accountingDataSource.updateItem(
      accountingId,
      accounting,
    );
  }

  @override
  updateStartAndEndDate({
    required Timestamp newStartAt,
    required Timestamp newEndAt,
  }) {
    accountingDataSource.updateStartAndEndDate(
      newStartAt: newStartAt,
      newEndAt: newEndAt,
    );
  }

  @override
  Map<String, dynamic> updateSum({required List<AccountingModel> lists}) {
    return accountingDataSource.updateSum(
      lists: lists,
    );
  }

  @override
  String? get userId => accountingDataSource.userId;
}
