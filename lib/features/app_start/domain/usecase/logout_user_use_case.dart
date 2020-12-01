//import 'package:amplify_core/amplify_core.dart';
import 'package:dartz/dartz.dart';
import 'package:gimme_now_flutter/core/amplify_auth_service.dart';
import 'package:gimme_now_flutter/core/error/failure.dart';
import 'package:gimme_now_flutter/core/service_locator.dart';
import 'package:gimme_now_flutter/features/registration_or_login/domain/usecase/base_use_case.dart';

abstract class LogOutUserUseCase implements BaseUseCase<bool, NoParams> {}

class LogOutUserUseCaseImpl implements LogOutUserUseCase {
  final userAuthService = sl<UserAuthService>();

  @override
  Future<Either<Failure, bool>> execute(NoParams noParams) async {
    try {
      await userAuthService.signOut();
      return Right(true);
    } catch (e) {
      return Left(GeneralFailure(failureMessage: e.toString()));
    }
  }
}

class NoParams {
  NoParams();
}
