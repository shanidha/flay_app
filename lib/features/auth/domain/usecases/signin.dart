import 'package:dartz/dartz.dart';
import 'package:flay_app/features/auth/data/models/user_signin_req.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../repository/auth_repository.dart';

class SigninUsecase implements UseCase<Either,UserSigninReq> {


  @override
  Future<Either> call({UserSigninReq ? params}) async {
    return await sl<AuthRepository>().signin(params!);
  }

  
}
