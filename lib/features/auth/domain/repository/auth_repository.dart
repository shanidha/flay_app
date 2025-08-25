
import 'package:dartz/dartz.dart';

import '../../data/models/user_creation.dart';
import '../../data/models/user_signin_req.dart';

abstract class AuthRepository {

  Future<Either> signup(UserCreationReq user);
   Future<Either> signUpWithGoogle();
  Future<Either> signin(UserSigninReq user);
  Future<Either> sendPasswordResetEmail(String email);
  Future<bool> isLoggedIn();
  Future<Either> getUser();
}
