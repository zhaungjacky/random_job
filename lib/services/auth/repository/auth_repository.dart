import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:random_job/services/entities/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserCredential>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<void> logout();

  Future<Either<Failure, UserCredential>> registerWithEmailPassword({
    required String email,
    required String password,
  });

  // Future<void> saveUser(String uid, String email);

  String? get userId;
  String? get email;
}
