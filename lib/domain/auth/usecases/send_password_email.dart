import 'package:dartz/dartz.dart';

import 'package:flay_app/core/usecase/usecase.dart';
import 'package:flay_app/domain/auth/repository/auth.dart';
import 'package:flay_app/service_locator.dart';

class SendPasswordResetEmailUseCase implements UseCase<Either,String> {

  @override
  Future<Either> call({String ? params}) async {
    return sl<AuthRepository>().sendPasswordResetEmail(params!);
  }

}
