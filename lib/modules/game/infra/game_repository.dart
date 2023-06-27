import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:infinitywords/modules/game/domain/errors/game_errors.dart';
import 'package:infinitywords/modules/game/domain/repositories/game_repository.dart';
import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';
import 'package:multiple_result/multiple_result.dart';

class GameRepositoryImp implements GameRepository {
  @override
  Future<Result<void, GameError>> changeFavoriteGameStatus(
    bool isFavorite,
    String gameId,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final game = await FirebaseFirestore.instance
          .collection('historics')
          .where('userId', isEqualTo: user.uid)
          .where('gameId', isEqualTo: gameId)
          .get();

      game.docs
          .firstWhere((e) => e['gameId'] == gameId)
          .data()
          .update('isFavorite', (value) => isFavorite);

      return const Success(null);
    } on FirebaseException catch (e) {
      return Error(GameError.firebaseError(e));
    }
  }

  @override
  Result<void, GameError> markWord(
    String word,
    GameEntity currentGame,
  ) {
    final wordExists = currentGame.words.contains(word);

    if (wordExists) {
      return const Success(null);
    }

    return Error(WordNotFoundError());
  }
}
