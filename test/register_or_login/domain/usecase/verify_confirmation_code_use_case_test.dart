import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gimme_now_flutter/core/amplify_auth_service.dart';
import 'package:gimme_now_flutter/core/error/failure.dart';
import 'package:gimme_now_flutter/core/service_locator.dart';
import 'package:gimme_now_flutter/features/registration_or_login/domain/usecase/verify_confirmation_code_use_case.dart';
import 'package:gimme_now_flutter/features/utils/constants/strings.dart';
import 'package:mockito/mockito.dart';

class MockAmplifyAuthService extends Mock implements UserAuthService {}

void main() {
  ConfirmCodeUseCase confirmCodeUseCase;
  MockAmplifyAuthService mockAmplifyAuthService;

  setUpAll(() {
    mockAmplifyAuthService = MockAmplifyAuthService();
    sl.registerSingleton<UserAuthService>(mockAmplifyAuthService);
    confirmCodeUseCase = ConfirmCodeUseCaseImpl();
  });

  test(
    'returns true when code verification successful',
    () async {
      when(mockAmplifyAuthService.confirmAccount(any, any)).thenAnswer((_) => Future.value(true));
      final result = await confirmCodeUseCase.execute(
        ConfirmCodeParams(email: "dhoju.ramesh03@gmail.com", code: "123456"),
      );
      expect(result, Right(true));
    },
  );

  test(
    'returns false when code verification failed',
    () async {
      when(mockAmplifyAuthService.confirmAccount(any, any)).thenAnswer((_) => Future.value(false));
      final result = await confirmCodeUseCase.execute(
        ConfirmCodeParams(email: "dhoju.ramesh03@gmail.com", code: "123456"),
      );
      expect(result,  Left(GeneralFailure(failureMessage: codeVerificationFailed)));
    },
  );

  test(
    'returns failure when some error occurs',
    () async {
      when(mockAmplifyAuthService.confirmAccount(any, any)).thenThrow(Exception());
      final result = await confirmCodeUseCase.execute(
        ConfirmCodeParams(email: "dhoju.ramesh03@gmail.com", code: "123456"),
      );
      expect(result, Left(GeneralFailure(failureMessage: codeVerificationFailed)));
    },
  );
}
