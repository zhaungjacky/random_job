import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_job/services/feathers/accounting/datasources/accounting_datasource.dart';
import 'package:random_job/services/feathers/accounting/model/accounting_category_type.dart';
import 'package:random_job/services/feathers/accounting/model/accounting_in_or_out_type.dart';
import 'package:random_job/services/feathers/accounting/model/accounting_model.dart';
import 'package:random_job/services/utils/utils.dart';

class AccountingDataSourceImpl implements AccountingDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  String? get userId => _auth.currentUser?.uid;

  static String mainCollection = "accountings";
  static String secondaryCollection = "accounting";
  static bool isAccountingStreamDescending = true;
  static String route() => "/accounting";

  Timestamp _startAt = DateProvider.staticAccountingStartAt();
  Timestamp _endAt = DateProvider.staticAccountingEndAt();

  // @override
  @override
  Timestamp get startAt => !isAccountingStreamDescending ? _startAt : _endAt;
  // @override
  @override
  Timestamp get endAt => isAccountingStreamDescending ? _startAt : _endAt;

  @override
  Future<void> addItem(AccountingModel accounting) async {
    //get current user info
    try {
      await _firestore
          .collection(mainCollection)
          .doc(userId)
          // .set(newMessage.toMap());
          .collection(secondaryCollection)
          .add(accounting.toMap());
    } catch (err) {
      throw Exception(err.toString());
    }
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
    try {
      final res = _firestore
          .collection(mainCollection)
          .doc(uid)
          .collection(secondaryCollection)
          .orderBy(
            "date",
            descending: isDescending,
          )
          .startAt(
        [startAt],
      ).endAt(
        [endAt],
      ).snapshots();
      return (res);
    } on FirebaseException catch (err) {
      throw MyException(err.code);
    }
  }

  @override
  Future<void> updateItem(
    String accountingId,
    AccountingModel accounting,
  ) async {
    try {
      await _firestore
          .collection(mainCollection)
          .doc(userId)
          .collection(secondaryCollection)
          .doc(accountingId)
          .set(accounting.toMap());
    } on FirebaseException catch (err) {
      throw MyException(err.code);
    }
  }

  @override
  Future<void> deleteItem(String id) async {
    try {
      await _firestore
          .collection(mainCollection)
          .doc(userId)
          .collection(secondaryCollection)
          .doc(id)
          .delete();
    } on FirebaseException catch (err) {
      throw MyException(err.code);
    }
  }

  @override
  Map<String, double> calculateMonthAmmount({
    required List<AccountingModel> lists,
  }) {
    if (lists.isNotEmpty) {
      double expense = 0;
      double incoming = 0;
      for (var accounting in lists) {
        if (accounting.type == AccountingInOrOutType.incoming.name) {
          incoming += double.parse((accounting.amount!).toStringAsFixed(2));
        } else {
          expense += double.parse((accounting.amount!).toStringAsFixed(2));
        }
      }

      return {
        'expense': double.parse(expense.toStringAsFixed(2)),
        'incoming': double.parse(incoming.toStringAsFixed(2)),
      };
      // return;
    }
    return {
      'expense': 0,
      'incoming': 0,
    };
  }

  @override
  Map<AccountingInOrOutType, double>? getChartDataInAndOut(
    List<AccountingModel> lists,
  ) {
    Map<AccountingInOrOutType, double> obj = {};
    if (lists.isEmpty) return {};
    // lists.sort((a, b) => a.date.compareTo(b.date) < 0 ? 0 : 1);
    for (final item in lists) {
      final currentNum = double.parse(item.amount!.toStringAsFixed(2));
      if (item.type == AccountingInOrOutType.incoming.name) {
        obj[AccountingInOrOutType.incoming] = double.parse(
            (obj[AccountingInOrOutType.incoming] == null
                    ? 0 + currentNum
                    : obj[AccountingInOrOutType.incoming]! + currentNum)
                .toStringAsFixed(2));
      } else {
        obj[AccountingInOrOutType.outgoing] = double.parse(
            (obj[AccountingInOrOutType.outgoing] == null
                    ? 0 + currentNum
                    : obj[AccountingInOrOutType.outgoing]! + currentNum)
                .toStringAsFixed(2));
      }
    }

    return obj;
  }

  @override
  Map<AccountingCategoryType, double>? getChartDataOutgoing(
    List<AccountingModel> lists,
  ) {
    Map<AccountingCategoryType, double> obj = {};
    if (lists.isEmpty) return {};

    // lists.sort((a, b) => a.date.compareTo(b.date) < 0 ? 0 : 1);
    for (final item in lists) {
      final key = AccountingCategoryType.fromString(item.category!)!;
      if (item.type == AccountingInOrOutType.outgoing.name) {
        // amount += item.amount;
        obj[key] = double.parse(
            (obj[key] == null ? 0 + item.amount! : obj[key]! + item.amount!)
                .toStringAsFixed(2));
      }
    }
    return obj;
  }

  @override
  Map<String, dynamic> updateSum({
    required List<AccountingModel> lists,
  }) {
    final res = calculateMonthAmmount(lists: lists);
    final chartDataBar = getChartDataInAndOut(lists);
    final chartDataPie = getChartDataOutgoing(lists);
    final state = {
      'lists': lists,
      'expense': res['expense'],
      'incoming': res['incoming'],
      'chartDataBar': chartDataBar,
      'chartDataPie': chartDataPie,
      // 'showChart': showChart,
      // 'showBarChart': showBarChart,
    };

    return state;
  }

  @override
  updateStartAndEndDate({
    required Timestamp newStartAt,
    required Timestamp newEndAt,
  }) async {
    if (newStartAt.compareTo(newEndAt) < 0) {
      _startAt = newStartAt;
      _endAt = newEndAt;
    } else {
      _startAt = newEndAt;
      _endAt = newStartAt;
    }
  }

  @override
  resetStartAndEndDate() async {
    _startAt = DateProvider.staticAccountingStartAt();
    _endAt = DateProvider.staticAccountingEndAt();
  }
}
