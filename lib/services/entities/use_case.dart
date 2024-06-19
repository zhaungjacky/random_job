import 'package:fpdart/fpdart.dart';
import 'package:random_job/services/entities/failure.dart';

abstract interface class AuthUseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> callLogin(Params params);
  Future<Either<Failure, SuccessType>> callRegister(Params params);
  Future<void> callLogout();
}

class NoParams {}
