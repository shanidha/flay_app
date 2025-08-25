import 'package:dartz/dartz.dart';

import 'package:flay_app/core/usecase/usecase.dart';
import 'package:flay_app/features/auth/domain/repository/auth_repository.dart';
import 'package:flay_app/service_locator.dart';

class SendPasswordResetEmailUseCase implements UseCase<Either,String> {

  @override
  Future<Either> call({String ? params}) async {
    return sl<AuthRepository>().sendPasswordResetEmail(params!);
  }

}
