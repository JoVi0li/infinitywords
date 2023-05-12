import 'package:firebase_auth/firebase_auth.dart';

abstract class GoogleSignInError extends FirebaseAuthException {
  GoogleSignInError({
    required super.code,
    required super.message,
    required this.error,
  });
  final String error;
}

class GenericSignInError extends GoogleSignInError {
  GenericSignInError({
    required super.code,
    required super.message,
    required super.error,
  });
}

class AccountExistsWithDifferentCredentialError extends GoogleSignInError {
  AccountExistsWithDifferentCredentialError()
      : super(
          code: 'account-exists-with-different-credential',
          error: 'E-mail inválido',
          message:
              'Verifique seu e-mail e tente novamente. Se o erro persistir, entre em contato com o suporte.',
        );
}

class InvalidCredential extends GoogleSignInError {
  InvalidCredential()
      : super(
          code: 'invalid-credential',
          error: 'Credencial inválida',
          message: 'Verifique sua conta e tente novamente.',
        );
}

class OperationNotAllowed extends GoogleSignInError {
  OperationNotAllowed()
      : super(
          code: 'operation-not-allowed',
          error: 'Operação não permitida',
          message: 'Contate o suporte e informe o erro.',
        );
}

class UserDisabled extends GoogleSignInError {
  UserDisabled()
      : super(
          code: 'user-disabled',
          error: 'Usuário desabilitado',
          message: 'Contate o suporte e informe o erro.',
        );
}

class UserNotFound extends GoogleSignInError {
  UserNotFound()
      : super(
          code: 'user-not-found',
          error: 'Usuário não encontrado',
          message: 'Verifique suas credenciais e tente novamente.',
        );
}

class WrongPassword extends GoogleSignInError {
  WrongPassword()
      : super(
          code: 'wrong-password',
          error: 'E-mail ou senha inválidos',
          message: 'Verifique suas credenciais e tente novamente.',
        );
}

class InvalidVerificationCode extends GoogleSignInError {
  InvalidVerificationCode()
      : super(
          code: 'invalid-verification-code',
          error: 'Código de verificação inválido',
          message: 'Verifique seu código e tente novamente.',
        );
}

class InvalidVerificationId extends GoogleSignInError {
  InvalidVerificationId()
      : super(
          code: 'invalid-verification-id',
          error: 'Identificador de verificador inválido',
          message: 'Verifique seu identificador e tente novamente.',
        );
}
