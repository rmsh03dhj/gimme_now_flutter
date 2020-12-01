import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gimme_now_flutter/core/error/failure.dart';
import 'package:gimme_now_flutter/core/service_locator.dart';
import 'package:gimme_now_flutter/features/registration_or_login/data/models/user.dart';
import 'package:gimme_now_flutter/features/registration_or_login/domain/usecase/resend_confirmation_code_use_case.dart';
import 'package:gimme_now_flutter/features/registration_or_login/domain/usecase/sign_in_use_case.dart';
import 'package:gimme_now_flutter/features/registration_or_login/domain/usecase/sign_up_use_case.dart';
import 'package:gimme_now_flutter/features/registration_or_login/domain/usecase/verify_confirmation_code_use_case.dart';
import 'package:gimme_now_flutter/features/registration_or_login/presentation/bloc/registration_or_login_bloc.dart';
import 'package:gimme_now_flutter/features/registration_or_login/presentation/bloc/registration_or_login_event.dart';
import 'package:gimme_now_flutter/features/registration_or_login/presentation/bloc/registration_or_login_state.dart';
import 'package:mockito/mockito.dart';

class MockSignInUseCase extends Mock implements SignInUseCase {}

class MockSignUpUseCase extends Mock implements SignUpUseCase {}

class MockConfirmCodeUseCase extends Mock implements ConfirmCodeUseCase {}

class MockResendConfirmCodeUseCase extends Mock implements ResendConfirmCodeUseCase {}

void main() {
  MockSignInUseCase mockSignInUseCase;
  MockSignUpUseCase mockSignUpUseCase;
  MockConfirmCodeUseCase mockConfirmCodeUseCase;
  MockResendConfirmCodeUseCase mockResendConfirmCodeUseCase;

  setUpAll(() {
    mockSignInUseCase = MockSignInUseCase();
    mockSignUpUseCase = MockSignUpUseCase();
    mockConfirmCodeUseCase = MockConfirmCodeUseCase();
    mockResendConfirmCodeUseCase = MockResendConfirmCodeUseCase();

    sl.allowReassignment = true;
    sl.registerSingleton<SignInUseCase>(mockSignInUseCase);
    sl.registerSingleton<SignUpUseCase>(mockSignUpUseCase);
    sl.registerSingleton<ConfirmCodeUseCase>(mockConfirmCodeUseCase);
    sl.registerSingleton<ResendConfirmCodeUseCase>(mockResendConfirmCodeUseCase);
  });

  test(
      'Register or login bloc emits [RegistrationOrLoginProcessingState and ConfirmRegistrationStepState] when user signs up successfully',
      () {
    when(mockSignUpUseCase.execute(any)).thenAnswer((_) async => Right(true));

    final bloc = RegistrationOrLoginBloc();

    bloc.add(SignUpPressed("dhoju.ramesh03@gmail.com", "123456"));

    expectLater(
      bloc,
      emitsInOrder([
        RegistrationOrLoginProcessingState(),
        ConfirmRegistrationStepState(User(email: "dhoju.ramesh03@gmail.com")),
      ]),
    );
  });

  test(
      'Register or login bloc emits [RegistrationOrLoginProcessingState and SignUpFailedState] when user signs up fails',
      () {
    when(mockSignUpUseCase.execute(any)).thenAnswer((_) async => Left(GeneralFailure(failureMessage: "Failed")));

    final bloc = RegistrationOrLoginBloc();

    bloc.add(SignUpPressed("dhoju.ramesh03@gmail.com", "123456"));

    expectLater(
      bloc,
      emitsInOrder([
        RegistrationOrLoginProcessingState(),
        SignUpFailedState("Failed"),
      ]),
    );
  });

  test(
      'Register or login bloc emits [RegistrationOrLoginProcessingState and SignUpSuccessState] when user confirms code successfully',
      () {
    when(mockConfirmCodeUseCase.execute(any)).thenAnswer((_) async => Right(true));

    final bloc = RegistrationOrLoginBloc();

    bloc.add(ConfirmCodeEntered("dhoju.ramesh03@gmail.com", "123456"));

    expectLater(
      bloc,
      emitsInOrder([
        RegistrationOrLoginProcessingState(),
        SignUpSuccessState("dhoju.ramesh03@gmail.com"),
      ]),
    );
  });

  test(
      'Register or login bloc emits [RegistrationOrLoginProcessingState and SignUpFailedState] when user fails confirming code',
      () {
    when(mockConfirmCodeUseCase.execute(any)).thenAnswer((_) async => Left(GeneralFailure(failureMessage: "Failed")));

    final bloc = RegistrationOrLoginBloc();

    bloc.add(ConfirmCodeEntered("dhoju.ramesh03@gmail.com", "123456"));

    expectLater(
      bloc,
      emitsInOrder([
        RegistrationOrLoginProcessingState(),
        SignUpFailedState("Failed"),
      ]),
    );
  });

  test(
      'Register or login bloc emits [RegistrationOrLoginProcessingState and SignInSuccessState] when user signs in successful',
      () {
    when(mockSignInUseCase.execute(any)).thenAnswer((_) async => Right(true));

    final bloc = RegistrationOrLoginBloc();

    bloc.add(SignInPressed("dhoju.ramesh03@gmail.com", "123456"));

    expectLater(
      bloc,
      emitsInOrder([
        RegistrationOrLoginProcessingState(),
        SignInSuccessState("dhoju.ramesh03@gmail.com"),
      ]),
    );
  });

  test(
      'Register or login bloc emits [RegistrationOrLoginProcessingState and RegistrationOrLoginFailedState] when user fails sign in',
      () {
    when(mockSignInUseCase.execute(any)).thenAnswer((_) async => Left(GeneralFailure(failureMessage: "Failed")));

    final bloc = RegistrationOrLoginBloc();

    bloc.add(SignInPressed("dhoju.ramesh03@gmail.com", "123456"));

    expectLater(
      bloc,
      emitsInOrder([
        RegistrationOrLoginProcessingState(),
        SignInFailedState("Failed"),
      ]),
    );
  });
}
