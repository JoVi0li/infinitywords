import 'package:firebase_core/firebase_core.dart';

abstract class GameError {
  final String error;
  final String message;
  final String code;

  GameError({
    required this.error,
    required this.message,
    required this.code,
  });

  factory GameError.firebaseError(
    FirebaseException e, {
    final String? error,
    final String? message,
  }) {
    return FirebaseGameError(
      error: error ?? 'Ops, algo deu errado',
      message: e.message ?? message ?? 'Tente novamente, por favor.',
      code: e.code,
    );
  }
}

class FirebaseGameError extends GameError {
  FirebaseGameError({
    required super.error,
    required super.message,
    required super.code,
  });
}

class WordNotFoundError extends GameError {
  WordNotFoundError()
      : super(
          code: 'word-not-found',
          message: 'Tente outra palavra, por favor.',
          error: 'Palavra não encontrada',
        );
}
