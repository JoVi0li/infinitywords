import 'package:dart_openai/openai.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class HomeError {
  final String code;
  final String message;
  final String error;

  HomeError({
    required this.code,
    required this.message,
    required this.error,
  });

  factory HomeError.genericError({
    final String? error,
    final String? message,
  }) {
    return GenericHomeError(
      error: error ?? 'Ops, algo deu errado',
      message: message ?? 'Tente novamente, por favor.',
    );
  }

  factory HomeError.firebaseError(FirebaseException e) {
    return HomeFirebaseError(
      code: e.code,
      message: e.message ?? '',
      error: 'Ops, algo deu errado',
      plugin: e.plugin,
    );
  }

  factory HomeError.openAIError(RequestFailedException e) {
    return HomeOpenAIError(
      code: e.statusCode.toString(),
      message: e.message,
      error: 'Ops, algo deu errado',
    );
  }
}

class GenericHomeError extends HomeError {
  GenericHomeError({
    required super.message,
    required super.error,
  }) : super(code: 'unknow');
}

class HomeFirebaseError extends HomeError {
  final String plugin;

  HomeFirebaseError({
    required super.code,
    required super.message,
    required super.error,
    required this.plugin,
  });
}

class HomeOpenAIError extends HomeError {
  HomeOpenAIError({
    required super.code,
    required super.message,
    required super.error,
  });
}

class UnauthenticateUser extends HomeError {
  UnauthenticateUser()
      : super(
          code: 'unauthenticate-user',
          error: 'Usuário não autenticado',
          message: 'Realize login para seguir utilizando o app.',
        );
}
