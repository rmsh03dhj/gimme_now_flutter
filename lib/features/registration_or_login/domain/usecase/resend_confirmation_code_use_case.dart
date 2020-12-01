import 'package:dartz/dartz.dart';
import 'package:gimme_now_flutter/core/amplify_auth_service.dart';
import 'package:gimme_now_flutter/core/error/failure.dart';
import 'package:gimme_now_flutter/core/service_locator.dart';
import 'package:gimme_now_flutter/features/utils/constants/strings.dart';

import 'base_use_case.dart';

abstract class ResendConfirmCodeUseCase implements BaseUseCase<bool, ResendConfirmCodeParams> {}

class ResendConfirmCodeUseCaseImpl implements ResendConfirmCodeUseCase {
  final userAuthServiceService = sl<UserAuthService>();

  @override
  Future<Either<Failure, bool>> execute(ResendConfirmCodeParams confirmCodeParams) async {
    try {
      await userAuthServiceService.resendConfirmationCode(confirmCodeParams.email);
        return Right(true);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: "Failed to sent verification code."));
    }
  }
}

class ResendConfirmCodeParams {
  final String email;

  ResendConfirmCodeParams({this.email});
}
