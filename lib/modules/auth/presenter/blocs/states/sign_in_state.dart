import 'package:infinitywords/modules/auth/domain/errors/google_play_sign_in_errors.dart';

abstract class SignInState {}

class InitialSignInState extends SignInState {}

class LoadingSignInState extends SignInState {}

class SuccessSignInState extends SignInState {}

class ErrorSignInState extends SignInState {
  ErrorSignInState._({this.googlePlayError});
  final GooglePlaySignInError? googlePlayError;

  factory ErrorSignInState.googlePlayError(
    GooglePlaySignInError googlePlaySignInError,
  ) {
    return ErrorSignInState._(
      googlePlayError: googlePlaySignInError,
    );
  }
}
