import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetRecentGamesError extends FirebaseException {
  GetRecentGamesError({
    required super.plugin,
    required super.code,
    required super.message,
    required this.error,
  });

  final String error;
}

class GenericGetRecentGamesError extends GetRecentGamesError {
  GenericGetRecentGamesError({
    required super.code,
    required super.message,
    required super.error,
  }) : super(plugin: 'firebase-firestore');
}

class UnauthenticateUserGetRecentGamesError extends GetRecentGamesError {
  UnauthenticateUserGetRecentGamesError()
      : super(
          plugin: 'firebase-firestore',
          code: 'unauthenticate',
          message: 'Realize login para prosseguir',
          error: 'Usuário não autenticado',
        );
}
