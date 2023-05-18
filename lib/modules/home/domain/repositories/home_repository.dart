import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';
import 'package:infinitywords/modules/home/domain/errors/create_game_errors.dart';
import 'package:infinitywords/modules/home/domain/errors/get_favorite_games_errors.dart';
import 'package:infinitywords/modules/home/domain/errors/get_recent_games_errors.dart';
import 'package:infinitywords/modules/home/domain/parameters/create_game_parameter.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class HomeRepository {
  Future<Result<List<GameEntity>, GetRecentGamesError>> getRecentGames();
  Future<Result<List<GameEntity>, GetFavoriteGamesError>> getFavoriteGames();
  Future<Result<String, CreateGameBaseError>> createGame(
    CreateGameParameter parameter,
  );
}
