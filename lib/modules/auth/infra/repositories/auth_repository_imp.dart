import 'dart:async';
import 'dart:ui';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:infinitywords/modules/auth/domain/errors/auth_errors.dart';
import 'package:infinitywords/modules/auth/domain/errors/google_sign_in_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:infinitywords/modules/auth/domain/repositories/auth_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AuthRepositoryImp implements AuthRepository {
  @override
  Future<Result<UserCredential, GoogleSignInError>> googleSignIn() async {
    try {
      final googleUser = await GoogleSignIn(
        signInOption: SignInOption.standard,
      ).signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return Success(userCredential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          return Error(AccountExistsWithDifferentCredentialError());
        case 'invalid-credential':
          return Error(InvalidCredential());
        case 'operation-not-allowed':
          return Error(OperationNotAllowed());
        case 'user-disabled':
          return Error(UserDisabled());
        case 'user-not-found':
          return Error(UserNotFound());
        case 'wrong-password':
          return Error(WrongPassword());
        case 'invalid-verification-code':
          return Error(InvalidVerificationCode());
        case 'invalid-verification-id':
          return Error(InvalidVerificationId());
        default:
          return Error(GenericSignInError(
            code: e.code,
            message: e.message,
            error: 'Algo deu errado',
          ));
      }
    } on FirebaseException catch (e) {
      return Error(GenericSignInError(
        code: e.code,
        message: e.message,
        error: 'Algo deu errado',
      ));
    } catch (e) {
      return Error(GenericSignInError(
        code: 'unknow',
        message: e.toString(),
        error: 'Algo deu errado',
      ));
    }
  }

  @override
  Result<void, AuthError> checkAuthState(
    Future<void> Function(User? user) onChange,
  ) {
    try {
      FirebaseAuth.instance.authStateChanges().listen(onChange);
      return const Success(null);
    } on FirebaseAuthException catch (e) {
      return Error(GenericAuthError(
        code: e.code,
        message: e.message,
      ));
    } on FirebaseException catch (e) {
      return Error(GenericAuthError(
        code: e.code,
        message: e.message,
      ));
    }
  }
}
