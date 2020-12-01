import 'package:dartz/dartz.dart';
import 'package:gimme_now_flutter/core/amplify_auth_service.dart';
import 'package:gimme_now_flutter/core/error/failure.dart';
import 'package:gimme_now_flutter/core/service_locator.dart';
import 'package:gimme_now_flutter/features/registration_or_login/domain/usecase/base_use_case.dart';

import 'logout_user_use_case.dart';

abstract class CheckForAuthenticationUseCase implements BaseUseCase<bool, NoParams> {}

class CheckForAuthenticationUseCaseImpl implements CheckForAuthenticationUseCase {
  final userAuthService = sl<UserAuthService>();
  @override
  Future<Either<Failure, bool>> execute(NoParams noParams) async {
    try {
      final authenticated = await userAuthService.checkAuthenticated();
      return Right(authenticated);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}
