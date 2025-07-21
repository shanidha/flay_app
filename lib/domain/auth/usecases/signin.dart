import 'package:dartz/dartz.dart';
import 'package:flay_app/data/auth/models/user_signin_req.dart';

import '../../../core/usecase/usecase.dart';
import '../../../service_locator.dart';
import '../repository/auth.dart';

class SigninUsecase implements UseCase<Either,UserSigninReq> {


  @override
  Future<Either> call({UserSigninReq ? params}) async {
    return await sl<AuthRepository>().signin(params!);
  }

  
}
