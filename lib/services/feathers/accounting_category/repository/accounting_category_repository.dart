import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_job/services/feathers/accounting_category/datasource/accounting_category_datasource.dart';

abstract interface class AccountingCategoryRepository {
  Stream<QuerySnapshot> getItems({
    required String mainCollection,
    required String? uid,
    required String secondaryCollection,
    required bool isDescending,
    required String key,
    required String value,
  });
  updateStartAndEndDate({
    required Timestamp newStartAt,
    required Timestamp newEndAt,
  });
  resetStartAndEndDate();
  String? get userId;
  Timestamp get startAt;
  Timestamp get endAt;
}

class AccountingCategoryRepositoryImpl implements AccountingCategoryRepository {
  final AccountingCategoryDatasource _accountingCategoryDatasource;
  const AccountingCategoryRepositoryImpl(
    AccountingCategoryDatasource accountingCategoryDatasource,
  ) : _accountingCategoryDatasource = accountingCategoryDatasource;

  static String mainCollection() => "accountings";
  static String secondaryCollection() => "accounting";
  static bool isAccountingCategoryStreamDescending() => true;

  @override
  Timestamp get startAt => _accountingCategoryDatasource.startAt;
  @override
  Timestamp get endAt => _accountingCategoryDatasource.endAt;
  @override
  String? get userId => _accountingCategoryDatasource.userId;

  @override
  Stream<QuerySnapshot> getItems({
    required String mainCollection,
    required String? uid,
    required String secondaryCollection,
    required bool isDescending,
    required String key,
    required String value,
  }) {
    return _accountingCategoryDatasource.getItems(
      mainCollection: mainCollection,
      uid: uid,
      secondaryCollection: secondaryCollection,
      isDescending: isDescending,
      key: key,
      value: value,
    );
  }

  @override
  resetStartAndEndDate() {
    _accountingCategoryDatasource.resetStartAndEndDate();
  }

  @override
  updateStartAndEndDate({
    required Timestamp newStartAt,
    required Timestamp newEndAt,
  }) {
    _accountingCategoryDatasource.updateStartAndEndDate(
      newStartAt: newStartAt,
      newEndAt: newEndAt,
    );
  }
}
