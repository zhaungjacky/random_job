import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:random_job/services/auth/repository/auth_repository.dart';
import 'package:random_job/services/services.dart';

class AuthUsecaseImpl implements AuthUseCase<UserCredential, AuthParams> {
  final AuthRepository authRepository;

  AuthUsecaseImpl(this.authRepository);
  @override
  Future<Either<Failure, UserCredential>> callLogin(AuthParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }

  @override
  Future<void> callLogout() async {
    return await authRepository.logout();
  }

  @override
  Future<Either<Failure, UserCredential>> callRegister(
      AuthParams params) async {
    return await authRepository.registerWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class AuthParams {
  final String email;
  final String password;

  AuthParams(
    this.email,
    this.password,
  );
}
