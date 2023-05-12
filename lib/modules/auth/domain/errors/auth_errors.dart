import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthError extends FirebaseAuthException {
  AuthError({
    required super.code,
    required super.message,
    required this.error,
  });
  final String error;
}

class GenericAuthError extends AuthError {
  GenericAuthError({
    required super.code,
    required super.message,
  }) : super(error: 'Algo deu errado');
}
