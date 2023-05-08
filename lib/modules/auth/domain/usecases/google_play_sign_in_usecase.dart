import 'package:firebase_auth/firebase_auth.dart';
import 'package:infinitywords/modules/auth/domain/errors/google_play_sign_in_errors.dart';
import 'package:infinitywords/modules/auth/domain/repositories/auth_repository.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class GooglePlaySignInUsecase {
  Future<Result<UserCredential, GooglePlaySignInError>> call();
}

class GooglePlaySignInUsecaseImp implements GooglePlaySignInUsecase {
  GooglePlaySignInUsecaseImp(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<UserCredential, GooglePlaySignInError>> call() async {
    return await _repository.googlePlaySignIn();
  }
}
