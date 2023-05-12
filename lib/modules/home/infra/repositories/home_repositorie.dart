import 'package:infinitywords/modules/home/domain/errors/get_recent_games_errors.dart';
import 'package:infinitywords/modules/home/domain/errors/get_favorite_games_errors.dart';
import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';
import 'package:infinitywords/modules/home/domain/repositories/home_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class HomeRepositoryImp implements HomeRepository {
  @override
  Future<Result<List<GameEntity>, GetFavoriteGamesError>>
      getFavoriteGames() async {
    // TODO: implement getFavoriteGames
    throw UnimplementedError();
  }

  @override
  Future<Result<List<GameEntity>, GetRecentGamesError>> getRecentGames() async {
    // TODO: implement getRecentGames
    throw UnimplementedError();
  }
}
