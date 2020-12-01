import 'package:dartz/dartz.dart';
import 'package:gimme_now_flutter/core/user_auth_service.dart';
import 'package:gimme_now_flutter/core/error/failure.dart';
import 'package:gimme_now_flutter/core/service_locator.dart';
import 'package:gimme_now_flutter/features/utils/constants/strings.dart';

import 'base_use_case.dart';

abstract class SignUpUseCase implements BaseUseCase<bool, SignUpParams> {}

class SignUpUseCaseImpl implements SignUpUseCase {
  final userAuthServiceService = sl<UserAuthService>();

  @override
  Future<Either<Failure, bool>> execute(SignUpParams signUpParams) async {
    try {
      final isSignedUp =
          await userAuthServiceService.signUp(signUpParams.email, signUpParams.password);
      if (isSignedUp) {
        return Right(true);
      } else {
        return Left(GeneralFailure(failureMessage: signUpFailed));
      }
    } catch (e) {
      return Left(GeneralFailure(failureMessage: signUpFailed));
    }
  }
}

class SignUpParams {
  final String email;
  final String password;

  SignUpParams({this.email, this.password});
}
