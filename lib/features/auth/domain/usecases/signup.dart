import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../data/models/user_creation.dart';
import '../../../../service_locator.dart';
import '../repository/auth_repository.dart';

class SignupUseCase implements UseCase<Either,UserCreationReq> {


  @override
  Future<Either> call({UserCreationReq ? params}) async {
    return await sl<AuthRepository>().signup(params!);
  }

  
}
