
import 'package:dartz/dartz.dart';

import 'package:google_sign_in/google_sign_in.dart' ;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_creation.dart';
import '../models/user_signin_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(UserCreationReq user);
  Future<Either> signin(UserSigninReq user);
  Future<Either> signupWithGoogle();
  Future<Either> sendPasswordResetEmail(String email);
  Future<bool> isLoggedIn();
  Future<Either> getUser();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signup(UserCreationReq user) async {
    try {
      var returnedData = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email!,
            password: user.password!,
          );

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(returnedData.user!.uid)
          .set({
            'userName': user.userName,
            'email': user.email,
            'gender': user.gender,
            'image': returnedData.user!.photoURL,
            'userId': returnedData.user!.uid,
          });

      return const Right('Sign up was successfull');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signin(UserSigninReq user) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );
      return const Right('Login was successfull');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'invalid-email') {
        message = 'Not user found for this email';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for this user';
      }

      return Left(message);
    }
  }

  @override
  Future<Either> sendPasswordResetEmail(String email) async {
    try {
         await FirebaseAuth.instance.setLanguageCode('en');
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      return const Right('Password reset email is sent');
    }on FirebaseAuthException catch (e) {
      
      final msg = switch (e.code) {
        'invalid-email'         => 'That email address is not valid.',
        'user-not-found'        => 'No account found for this email.',
        'too-many-requests'     => 'Too many requests. Try again in a few minutes.',
        'network-request-failed'=> 'Network issue. Check your connection.',
        'missing-android-pkg-name'   => 'App package not set. Add ActionCodeSettings.',
        'missing-continue-uri'       => 'Missing continue URL. Add ActionCodeSettings.',
        'invalid-continue-uri'       => 'Invalid continue URL. Fix ActionCodeSettings.url.',
        'unauthorized-continue-uri'  => 'Continue URL not whitelisted in Firebase Console.',
        _ => 'Reset failed: ${e.code}',
      };
      return Left(msg);
    }  catch (e) {
      
      return const Left('Please try again');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      var userData = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser?.uid)
          .get()
          .then((value) => value.data());
      return Right(userData);
    } catch (e) {
      return const Left('Please try again');
    }
  }

  @override
  Future<Either> signupWithGoogle() async {
     
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) {
        return const Left('Sign-in    ');
      }
      final  GoogleSignInAuthentication gAuth = await gUser.authentication;
      final AuthCredential  credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
    final  cred = await FirebaseAuth.instance.signInWithCredential(credential);

      final user = cred.user;
      if (user == null) return const Left('Google sign-in failed');

      // Create/merge the user document
      final doc = FirebaseFirestore.instance.collection('Users').doc(user.uid);
      await doc.set({
        'userName': user.displayName ?? '',
        'email': user.email,
        'gender': null,
        'image': user.photoURL,
        'userId': user.uid,
        'provider': 'google',
      }, SetOptions(merge: true));

      return const Right('Google sign-in successful');
    } on FirebaseAuthException catch (e) {
      return Left('Google sign-in failed: ${e.code}');
    } catch (e) {
      return const Left('Google sign-in failed. Please try again.');
    }
  }
}
