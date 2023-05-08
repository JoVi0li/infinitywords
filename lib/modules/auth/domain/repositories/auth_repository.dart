import 'package:firebase_auth/firebase_auth.dart';
import 'package:infinitywords/modules/auth/domain/errors/google_play_sign_in_errors.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AuthRepository {
  Future<Result<UserCredential, GooglePlaySignInError>> googlePlaySignIn();
}
