import 'package:dartz/dartz.dart';
import 'package:flay_app/core/usecase/usecase.dart';
import 'package:flay_app/features/auth/data/models/user_creation.dart';
import 'package:flay_app/features/auth/domain/repository/auth_repository.dart';
import 'package:flay_app/service_locator.dart';

class SignupWithGoogleUseCase implements UseCase<Either,UserCreationReq> {


  @override
  Future<Either> call({UserCreationReq ? params}) async {
    return await sl<AuthRepository>().signUpWithGoogle();
  }

  
}