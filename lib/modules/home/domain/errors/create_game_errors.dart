import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_openai/openai.dart';

abstract class CreateGameBaseError {
  final String code;
  final String message;
  final String error;

  CreateGameBaseError({
    required this.code,
    required this.message,
    required this.error,
  });
}

abstract class CreateGameFirebaseError extends FirebaseException
    implements CreateGameBaseError {
  CreateGameFirebaseError() : super(plugin: 'firebase-firestore');
}

abstract class CreateGameOpenAIError extends RequestFailedException
    implements CreateGameBaseError {
  CreateGameOpenAIError(
    super.message,
    super.statusCode,
  );
}

class UnauthenticateUserCreateGameFirebaseError
    implements CreateGameFirebaseError {
  const UnauthenticateUserCreateGameFirebaseError();
  @override
  String get error => 'Usuário não autenticado';

  @override
  String get code => 'unauthenticate';

  @override
  String get message => 'Realize login para prosseguir';

  @override
  String get plugin => 'firebase-firestore';

  @override
  StackTrace? get stackTrace => null;
}
