import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_job/services/feathers/accounting/accounting.dart';

abstract interface class AccountingRepository {
  Future<void> addItem(AccountingModel accounting);
  Future<void> deleteItem(String id);
  Future<void> updateItem(
    String id,
    AccountingModel accounting,
  );
  Stream<QuerySnapshot> getItems({
    required String mainCollection,
    required String? uid,
    required String secondaryCollection,
    required bool isDescending,
    required Timestamp startAt,
    required Timestamp endAt,
  });
  Map<String, dynamic> updateSum({
    required List<AccountingModel> lists,
  });

  Map<String, double> calculateMonthAmmount({
    required List<AccountingModel> lists,
  });

  Map<AccountingCategoryType, double>? getChartDataOutgoing(
    List<AccountingModel> lists,
  );

  Map<AccountingInOrOutType, double>? getChartDataInAndOut(
    List<AccountingModel> lists,
  );

  updateStartAndEndDate({
    required Timestamp newStartAt,
    required Timestamp newEndAt,
  });
  resetStartAndEndDate();
  String? get userId;
  Timestamp get startAt;
  Timestamp get endAt;
}
