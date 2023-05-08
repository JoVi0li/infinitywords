import 'package:firebase_auth/firebase_auth.dart';

abstract class GooglePlaySignInError extends FirebaseAuthException {
  GooglePlaySignInError({
    required super.code,
    required super.message,
    required this.error,
  });
  final String error;
}

class GenericPlaySignInError extends GooglePlaySignInError {
  GenericPlaySignInError({
    required super.code,
    required super.message,
    required super.error,
  });
}

class AccountExistsWithDifferentCredentialError extends GooglePlaySignInError {
  AccountExistsWithDifferentCredentialError()
      : super(
          code: 'account-exists-with-different-credential',
          error: 'E-mail inválido',
          message:
              'Verifique seu e-mail e tente novamente. Se o erro persistir, entre em contato com o suporte.',
        );
}

class InvalidCredential extends GooglePlaySignInError {
  InvalidCredential()
      : super(
          code: 'invalid-credential',
          error: 'Credencial inválida',
          message: 'Verifique sua conta e tente novamente.',
        );
}

class OperationNotAllowed extends GooglePlaySignInError {
  OperationNotAllowed()
      : super(
          code: 'operation-not-allowed',
          error: 'Operação não permitida',
          message: 'Contate o suporte e informe o erro.',
        );
}

class UserDisabled extends GooglePlaySignInError {
  UserDisabled()
      : super(
          code: 'user-disabled',
          error: 'Usuário desabilitado',
          message: 'Contate o suporte e informe o erro.',
        );
}

class UserNotFound extends GooglePlaySignInError {
  UserNotFound()
      : super(
          code: 'user-not-found',
          error: 'Usuário não encontrado',
          message: 'Verifique suas credenciais e tente novamente.',
        );
}

class WrongPassword extends GooglePlaySignInError {
  WrongPassword()
      : super(
          code: 'wrong-password',
          error: 'E-mail ou senha inválidos',
          message: 'Verifique suas credenciais e tente novamente.',
        );
}

class InvalidVerificationCode extends GooglePlaySignInError {
  InvalidVerificationCode()
      : super(
          code: 'invalid-verification-code',
          error: 'Código de verificação inválido',
          message: 'Verifique seu código e tente novamente.',
        );
}

class InvalidVerificationId extends GooglePlaySignInError {
  InvalidVerificationId()
      : super(
          code: 'invalid-verification-id',
          error: 'Identificador de verificador inválido',
          message: 'Verifique seu identificador e tente novamente.',
        );
}
