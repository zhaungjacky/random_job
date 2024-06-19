// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:random_job/services/auth/auth.dart';
import 'package:random_job/services/services.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSourceRepository authDataSourceRepository;

  AuthRepositoryImpl(this.authDataSourceRepository);
  @override
  String? get email => authDataSourceRepository.email;
  @override
  String? get userId => authDataSourceRepository.userId;

  @override
  Future<Either<Failure, UserCredential>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final res = authDataSourceRepository.loginWithEmailPassword(
      email: email,
      password: password,
    );
    return res;
  }

  @override
  Future<void> logout() async {
    await authDataSourceRepository.logout();
  }

  @override
  Future<Either<Failure, UserCredential>> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final res = await authDataSourceRepository.registerWithEmailPassword(
      email: email,
      password: password,
    );
    return res;
  }
}

// class AuthRepositoryImpl implements AuthRepository {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   final FirebaseFirestore _storge = FirebaseFirestore.instance;
//   static String mainCollection() => "users";
//   String? _email;
//   String? _userId;
//   @override
//   String? get email => _email;

//   @override
//   String? get userId => _userId;

//   @override
//   Future<UserCredential> login(
//     String email,
//     String password,
//   ) async {
//     try {
//       final UserCredential userCredential =
//           await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       final loginedEmail = userCredential.user?.email;
//       final loginedUid = userCredential.user?.uid;
//       await saveUser(
//         loginedUid,
//         loginedEmail,
//       );
//       if (loginedEmail != null) {
//         await SharedModel.setEmail(loginedEmail);
//         _email = loginedEmail;
//         _userId = loginedUid;
//       }
//       return userCredential;
//     } on FirebaseException catch (err) {
//       throw MyException(err.code);
//     }
//   }

//   @override
//   Future<void> logout() async {
//     try {
//       await _auth.signOut();
//       _email = null;
//       _userId = null;
//     } on FirebaseException catch (err) {
//       throw MyException(err.code);
//     }
//   }

//   @override
//   Future<UserCredential> register(String email, String password) async {
//     try {
//       final UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       final loginedUid = userCredential.user?.uid;
//       final loginedEmail = userCredential.user?.email;
//       await saveUser(
//         loginedUid,
//         loginedEmail,
//       );
//       if (loginedEmail != null) {
//         await SharedModel.setEmail(loginedEmail);
//         _email = loginedEmail;
//         _userId = loginedUid;
//       }
//       return userCredential;
//     } catch (err) {
//       throw MyException(err.toString());
//     }
//   }

//   @override
//   Future<void> saveUser(String? uid, String? email) async {
//     if (uid == null || email == null) return;
//     await _storge
//         .collection(
//           mainCollection(),
//         )
//         .doc(uid)
//         .set(
//       {
//         "uid": uid,
//         "emai": email,
//       },
//     );
//   }
// }
