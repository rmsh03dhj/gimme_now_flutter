import 'package:dartz/dartz.dart';
import 'package:gimme_now_flutter/core/user_auth_service.dart';
import 'package:gimme_now_flutter/core/error/failure.dart';
import 'package:gimme_now_flutter/core/service_locator.dart';
import 'package:gimme_now_flutter/features/utils/constants/strings.dart';

import 'base_use_case.dart';

abstract class SignInUseCase implements BaseUseCase<bool, SignInParams> {}

class SignInUseCaseImpl implements SignInUseCase {
  final userAuthServiceService = sl<UserAuthService>();
  @override
  Future<Either<Failure, bool>> execute(SignInParams signInParams) async {
    try {
      final isSignedIn =
          await userAuthServiceService.signIn(signInParams.email, signInParams.password);
      if (isSignedIn) {
        return Right(true);
      } else {
        return Left(GeneralFailure(failureMessage: signInFailed));
      }
    } catch (e) {
      return Left(GeneralFailure(failureMessage: signInFailed));
    }
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({this.email, this.password});
}
