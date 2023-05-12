import 'package:infinitywords/modules/auth/domain/errors/google_sign_in_errors.dart';

abstract class SignInState {}

class InitialSignInState extends SignInState {}

class LoadingSignInState extends SignInState {}

class SuccessSignInState extends SignInState {}

class ErrorSignInState extends SignInState {
  ErrorSignInState._({this.googleError});
  final GoogleSignInError? googleError;

  factory ErrorSignInState.googleError(
    GoogleSignInError googleSignInError,
  ) {
    return ErrorSignInState._(
      googleError: googleSignInError,
    );
  }
}
