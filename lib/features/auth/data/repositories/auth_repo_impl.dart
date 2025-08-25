import 'package:dartz/dartz.dart';

import '../../domain/repository/auth_repository.dart';
import '../../../../service_locator.dart';
import '../models/user.dart';
import '../models/user_creation.dart';
import '../models/user_signin_req.dart';
import '../datasources/auth_firebase_datasource.dart';

class AuthRepositoryImpl extends AuthRepository {

  
  @override
  Future<Either> signup(UserCreationReq user) async {
    return await sl<AuthFirebaseService>().signup(user);
  }
  
 
  @override
  Future<Either> signin(UserSigninReq user) async {
     return await sl<AuthFirebaseService>().signin(user);
  }
  
  @override
  Future<Either> sendPasswordResetEmail(String email) async {
    return await sl<AuthFirebaseService>().sendPasswordResetEmail(email);
  }
  
  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthFirebaseService>().isLoggedIn();
  }
  
  @override
  Future < Either > getUser() async {
    var user = await sl < AuthFirebaseService > ().getUser();
    return user.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(
          UserModel.fromMap(data).toEntity()
        );
      }
    );
  }
  
  @override
  Future<Either> signUpWithGoogle() async{
    return await sl<AuthFirebaseService>().signupWithGoogle();
  }
  
}
