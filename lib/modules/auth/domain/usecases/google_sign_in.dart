import 'package:firebase_auth/firebase_auth.dart';
import 'package:infinitywords/modules/auth/domain/errors/google_sign_in_errors.dart';
import 'package:infinitywords/modules/auth/domain/repositories/auth_repository.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class GoogleSignInUsecase {
  Future<Result<UserCredential, GoogleSignInError>> call();
}

class GoogleSignInUsecaseImp implements GoogleSignInUsecase {
  GoogleSignInUsecaseImp(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<UserCredential, GoogleSignInError>> call() async {
    return await _repository.googleSignIn();
  }
}
