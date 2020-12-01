import 'package:dartz/dartz.dart';
import 'package:gimme_now_flutter/core/amplify_auth_service.dart';
import 'package:gimme_now_flutter/core/error/failure.dart';
import 'package:gimme_now_flutter/core/service_locator.dart';
import 'package:gimme_now_flutter/features/utils/constants/strings.dart';

import 'base_use_case.dart';

abstract class ConfirmCodeUseCase implements BaseUseCase<bool, ConfirmCodeParams> {}

class ConfirmCodeUseCaseImpl implements ConfirmCodeUseCase {
  final userAuthServiceService = sl<UserAuthService>();

  @override
  Future<Either<Failure, bool>> execute(ConfirmCodeParams confirmCodeParams) async {
    try {
      final res =
          await userAuthServiceService.confirmAccount(confirmCodeParams.email, confirmCodeParams.code);
      if (res) {
        return Right(true);
      } else {
        return Left(GeneralFailure(failureMessage: codeVerificationFailed));
      }
    } catch (e) {
      return Left(GeneralFailure(failureMessage: codeVerificationFailed));
    }
  }
}

class ConfirmCodeParams {
  final String email;
  final String code;

  ConfirmCodeParams({this.email, this.code});
}
