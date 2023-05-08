import 'package:google_sign_in/google_sign_in.dart';
import 'package:infinitywords/modules/auth/domain/errors/google_play_sign_in_errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:infinitywords/modules/auth/domain/repositories/auth_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AuthRepositoryImp implements AuthRepository {
  @override
  Future<Result<UserCredential, GooglePlaySignInError>>
      googlePlaySignIn() async {
    try {
      final googleUser = await GoogleSignIn(
        signInOption: SignInOption.games,
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
          return Error(GenericPlaySignInError(
            code: e.code,
            message: e.message,
            error: 'Algo deu errado',
          ));
      }
    } on FirebaseException catch (e) {
      return Error(GenericPlaySignInError(
        code: e.code,
        message: e.message,
        error: 'Algo deu errado',
      ));
    }
  }
}
