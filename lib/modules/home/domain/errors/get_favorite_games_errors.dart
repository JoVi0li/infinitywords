import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GetFavoriteGamesError extends FirebaseException {
  GetFavoriteGamesError({
    required super.plugin,
    required super.code,
    required super.message,
    required this.error,
  });

  final String error;
}

class GenericGetFavoriteGamesError extends GetFavoriteGamesError {
  GenericGetFavoriteGamesError({
    required super.code,
    required super.message,
    required super.error,
  }) : super(plugin: 'firebase-firestore');
}

class UnauthenticateUserGetFavoriteGamesError extends GetFavoriteGamesError {
  UnauthenticateUserGetFavoriteGamesError()
      : super(
          plugin: 'firebase-firestore',
          code: 'unauthenticate',
          message: 'Realize login para prosseguir',
          error: 'Usuário não autenticado',
        );
}
