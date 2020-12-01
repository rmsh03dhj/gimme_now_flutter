import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class BaseUseCase<TResult, TParams> {
  Future<Either<Failure, TResult>> execute(TParams params);
}
