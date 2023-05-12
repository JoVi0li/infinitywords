import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:infinitywords/modules/auth/domain/errors/auth_errors.dart';
import 'package:infinitywords/modules/auth/domain/errors/google_sign_in_errors.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AuthRepository {
  Future<Result<UserCredential, GoogleSignInError>> googleSignIn();
  Result<void, AuthError> checkAuthState(Future<void> Function(User? user) onChange);
}
