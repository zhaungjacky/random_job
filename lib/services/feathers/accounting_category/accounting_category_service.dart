import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_job/services/services.dart';

abstract interface class AccountingCategory {
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

class AccountingCategoryService implements AccountingCategory {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  String? get userId => _auth.currentUser?.uid;

  static String mainCollection = "accountings";
  static String secondaryCollection = "accounting";
  static bool isAccountingCategoryStreamDescending = true;
  // static String route() => "/accounting";

  Timestamp _startAt = DateProvider.staticAccountingStartAt();
  Timestamp _endAt = DateProvider.staticAccountingEndAt();

  // @override
  @override
  Timestamp get startAt =>
      !isAccountingCategoryStreamDescending ? _startAt : _endAt;
  // @override
  @override
  Timestamp get endAt =>
      isAccountingCategoryStreamDescending ? _startAt : _endAt;

  @override
  Stream<QuerySnapshot<Object?>> getItems({
    required String mainCollection,
    required String? uid,
    required String secondaryCollection,
    required bool isDescending,
    required String key,
    required String value,
  }) {
    try {
      final res = _firestore
          .collection(mainCollection)
          .doc(uid)
          .collection(secondaryCollection)
          .where(
            key,
            isEqualTo: value,
          )
          .orderBy(
            "category",
            descending: isDescending,
          )
          .snapshots();
      return res;
    } on FirebaseException catch (err) {
      throw MyException(err.code);
    }
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
