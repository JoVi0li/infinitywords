import 'package:infinitywords/modules/game/domain/errors/game_errors.dart';
import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class GameRepository {
  Future<Result<void, GameError>> addGametoHistoric(GameEntity game);
  Result<void, GameError> markWord(String word, GameEntity currentGame);
  Future<Result<void, GameError>> changeFavoriteGameStatus(
    bool isFavorite,
    String gameId,
  );
}
