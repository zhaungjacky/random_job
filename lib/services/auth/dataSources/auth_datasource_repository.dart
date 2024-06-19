import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:random_job/services/entities/failure.dart';
import 'package:random_job/services/utils/my_exception.dart';
import 'package:random_job/services/storage/localstorage.dart';

abstract interface class AuthDataSourceRepository {
  Future<Either<Failure, UserCredential>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<void> logout();

  Future<Either<Failure, UserCredential>> registerWithEmailPassword({
    required String email,
    required String password,
  });

  Future<void> saveUser({
    required String? uid,
    required String? email,
  });
  String? get userId;
  String? get email;
}

class AuthDatasourceRepositoryImpl implements AuthDataSourceRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _storge = FirebaseFirestore.instance;
  static String mainCollection() => "users";
  // String? _email;
  // String? _userId;
  @override
  String? get email => _auth.currentUser?.email;

  @override
  String? get userId => _auth.currentUser?.uid;

  // set setEmail(String email) {
  //   email = email;
  // }

  // set setUserId(String userId) {
  //   userId = userId;
  // }

  @override
  Future<Either<Failure, UserCredential>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final loginedEmail = userCredential.user?.email;
      final loginedUid = userCredential.user?.uid;
      await saveUser(
        email: loginedEmail,
        uid: loginedUid,
      );
      if (loginedEmail != null) {
        await SharedModel.setEmail(loginedEmail);
        // setEmail(loginedEmail);
        // _userId = loginedUid;
      }
      return right(userCredential);
    } on FirebaseException catch (err) {
      return left(Failure(
        err.code,
      ));
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _auth.signOut();
      // _email = null;
      // _userId = null;
    } on FirebaseException catch (err) {
      throw MyException(err.code);
    }
  }

  @override
  Future<Either<Failure, UserCredential>> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final loginedUid = userCredential.user?.uid;
      final loginedEmail = userCredential.user?.email;

      //save usercredential to localstorage
      await saveUser(
        uid: loginedUid,
        email: loginedEmail,
      );
      if (loginedEmail != null) {
        await SharedModel.setEmail(loginedEmail);
        // _email = loginedEmail;
        // _userId = loginedUid;
      }
      return right(userCredential);
    } catch (err) {
      return left(
        Failure(
          err.toString(),
        ),
      );
    }
  }

  @override
  Future<void> saveUser({
    required String? uid,
    required String? email,
  }) async {
    if (uid == null || email == null) return;
    await _storge
        .collection(
          mainCollection(),
        )
        .doc(uid)
        .set(
      {
        "uid": uid,
        "email": email,
      },
    );
  }
}
