import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_job/services/feathers/accounting/model/accounting_category_type.dart';
import 'package:random_job/services/feathers/accounting/model/accounting_in_or_out_type.dart';
import 'package:random_job/services/feathers/accounting/model/accounting_model.dart';
import 'package:random_job/services/utils/utils.dart';

abstract interface class Accounting {
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

  Map<String, double> calculateMonthAmmount(
      {required List<AccountingModel> lists});

  Map<AccountingCategoryType, double>? getChartDataOutgoing(
      List<AccountingModel> lists);

  Map<AccountingInOrOutType, double>? getChartDataInAndOut(
      List<AccountingModel> lists);

  updateStartAndEndDate({
    required Timestamp newStartAt,
    required Timestamp newEndAt,
  });
  resetStartAndEndDate();
  String? get userId;
  Timestamp get startAt;
  Timestamp get endAt;
}

class AccountingService implements Accounting {
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

  //delete todo
  @override
  Future<void> deleteItem(String id) async {
    await _firestore
        .collection(mainCollection)
        .doc(userId)
        .collection(secondaryCollection)
        .doc(id)
        .delete();
  }

  @override
  Future<void> updateItem(
    String accountingId,
    AccountingModel accounting,
    //   [
    //   String? text,
    //   DateTime? date,
    //   bool? isChecked,
    // ]
  ) async {
    await _firestore
        .collection(mainCollection)
        .doc(userId)
        .collection(secondaryCollection)
        .doc(accountingId)
        .set(accounting.toMap());
  }

  //get todos

  @override
  Stream<QuerySnapshot> getItems({
    required String mainCollection,
    required String? uid,
    required String secondaryCollection,
    required bool isDescending,
    required Timestamp startAt,
    required Timestamp endAt,
  }) {
    // print(startAt.toDate());
    // print(endAt.toDate());
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
    return res;
  }

  @override
  Map<String, dynamic> updateSum({required List<AccountingModel> lists}) {
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
    // _start = StartEndDateTimeProvider.dateStart;
    // _end = StartEndDateTimeProvider.dateEnd;
  }

  @override
  Map<String, double> calculateMonthAmmount(
      {required List<AccountingModel> lists}) {
    if (lists.isNotEmpty) {
      double expense = 0;
      double incoming = 0;
      for (var accounting in lists) {
        if (accounting.type == AccountingInOrOutType.incoming.name) {
          incoming += accounting.amount!;
        } else {
          expense += accounting.amount!;
        }
      }

      return {
        'expense': expense,
        'incoming': incoming,
      };
      // return;
    }
    return {
      'expense': 0,
      'incoming': 0,
    };
  }

  //  caculate data from out-detail
  @override
  Map<AccountingCategoryType, double>? getChartDataOutgoing(
      List<AccountingModel> lists) {
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

//  caculate data from in-and-out-sum
  @override
  Map<AccountingInOrOutType, double>? getChartDataInAndOut(
      List<AccountingModel> lists) {
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
/*
class AccountingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? get userId => _auth.currentUser?.uid;

  static String mainCollection = "accountings";
  static String secondaryCollection = "accounting";
  static bool isAccountingStreamDescending = true;

  // static Timestamp staticStartAt = !isAccountingStreamDescending
  //     ? Timestamp.fromDate(
  //         DateTime.now().subtract(
  //           const Duration(days: 90),
  //         ),
  //       )
  //     : Timestamp.fromDate(
  //         DateTime.now().add(
  //           const Duration(days: 10),
  //         ),
  //       );
  // static Timestamp staticEndAt = isAccountingStreamDescending
  //     ? Timestamp.fromDate(
  //         DateTime.now().subtract(
  //           const Duration(days: 90),
  //         ),
  //       )
  //     : Timestamp.fromDate(
  //         DateTime.now().add(
  //           const Duration(days: 10),
  //         ),
  //       );

  Timestamp _startAt = DateProvider.staticAccountingStartAt;
  Timestamp _endAt = DateProvider.staticAccountingEndAt;

  Timestamp get startAt => !isAccountingStreamDescending ? _startAt : _endAt;
  Timestamp get endAt => isAccountingStreamDescending ? _startAt : _endAt;

  Future<void> addAccounting(AccountingModel acccounting) async {
    //get current user info
    try {
      await _firestore
          .collection(mainCollection)
          .doc(userId)
          // .set(newMessage.toMap());
          .collection(secondaryCollection)
          .add(acccounting.toMap());
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  //delete todo
  Future<void> deleteAccounting(String id) async {
    //get current user info

    // final collectionRef = _firestore
    //     .collection(mainCollection)
    //     .doc(uid)
    //     .collection(secondaryCollection);

    // collectionRef.get().then((value) => print(value.docs[0].id));
    //0hX0YlelKdxmzwLr9chA

    await _firestore
        .collection(mainCollection)
        .doc(userId)
        .collection(secondaryCollection)
        .doc(id)
        .delete();
  }

  Future<void> updateAccounting(
    String accountingId,
    AccountingModel accounting,
    //   [
    //   String? text,
    //   DateTime? date,
    //   bool? isChecked,
    // ]
  ) async {
    await _firestore
        .collection(mainCollection)
        .doc(userId)
        .collection(secondaryCollection)
        .doc(accountingId)
        .set(accounting.toMap());
  }

  //get todos

  Stream<QuerySnapshot> getAccountings({
    required String mainCollection,
    required String? uid,
    required String secondaryCollection,
    required bool isDescending,
    required Timestamp startAt,
    required Timestamp endAt,
  }) {
    // print(startAt.toDate());
    // print(endAt.toDate());
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
    return res;
  }

  Map<String, dynamic> updateSum({required List<AccountingModel> lists}) {
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
    // _start = StartEndDateTimeProvider.dateStart;
    // _end = StartEndDateTimeProvider.dateEnd;
  }

  Map<String, double> calculateMonthAmmount(
      {required List<AccountingModel> lists}) {
    if (lists.isNotEmpty) {
      double expense = 0;
      double incoming = 0;
      for (var accounting in lists) {
        if (accounting.type == AccountingInOrOutType.incoming.name) {
          incoming += accounting.amount!;
        } else {
          expense += accounting.amount!;
        }
      }

      return {
        'expense': expense,
        'incoming': incoming,
      };
      // return;
    }
    return {
      'expense': 0,
      'incoming': 0,
    };
  }

  //  caculate data from out-detail
  Map<AccountingCategoryType, double>? getChartDataOutgoing(
      List<AccountingModel> lists) {
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

//  caculate data from in-and-out-sum
  Map<AccountingInOrOutType, double>? getChartDataInAndOut(
      List<AccountingModel> lists) {
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

  resetStartAndEndDate() async {
    _startAt = DateProvider.staticAccountingStartAt;
    _endAt = DateProvider.staticAccountingEndAt;
  }
}
*/