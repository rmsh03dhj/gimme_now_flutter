import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gimme_now_flutter/core/amplify_auth_service.dart';
import 'package:gimme_now_flutter/core/error/failure.dart';
import 'package:gimme_now_flutter/core/service_locator.dart';
import 'package:gimme_now_flutter/features/registration_or_login/domain/usecase/sign_in_use_case.dart';
import 'package:gimme_now_flutter/features/utils/constants/strings.dart';
import 'package:mockito/mockito.dart';

class MockAmplifyAuthService extends Mock implements UserAuthService {}

void main() {
  SignInUseCase signInUseCase;
  MockAmplifyAuthService mockAmplifyAuthService;

  setUpAll(() {
    mockAmplifyAuthService = MockAmplifyAuthService();
    sl.registerSingleton<UserAuthService>(mockAmplifyAuthService);
    signInUseCase = SignInUseCaseImpl();
  });

  test(
    'returns true when sign in successfully',
    () async {
      when(mockAmplifyAuthService.signIn(any, any)).thenAnswer((_) => Future.value(true));
      final result = await signInUseCase.execute(
        SignInParams(email: "dhoju.ramesh03@gmail.com", password: "123456"),
      );
      expect(result, Right(true));
    },
  );

  test(
    'returns failure when sign in failed',
    () async {
      when(mockAmplifyAuthService.signIn(any, any)).thenAnswer((_) => Future.value(false));
      final result = await signInUseCase.execute(
        SignInParams(email: "dhoju.ramesh03@gmail.com", password: "123456"),
      );
      expect(result, Left(GeneralFailure(failureMessage: signInFailed)));
    },
  );

  test(
    'returns failure when some error occurs',
    () async {
      when(mockAmplifyAuthService.signIn(any, any)).thenThrow(Exception());
      final result = await signInUseCase.execute(
        SignInParams(email: "dhoju.ramesh03@gmail.com", password: "123456"),
      );
      expect(result, Left(GeneralFailure(failureMessage: signInFailed)));
    },
  );
}
