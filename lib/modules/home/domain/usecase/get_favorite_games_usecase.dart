import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';
import 'package:infinitywords/modules/home/domain/errors/get_favorite_games_errors.dart';
import 'package:infinitywords/modules/home/domain/repositories/home_repository.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class GetFavoriteGamesUsecase {
  Future<Result<List<GameEntity>, GetFavoriteGamesError>> call();
}

class GetFavoriteGamesUsecaseImp implements GetFavoriteGamesUsecase {
  GetFavoriteGamesUsecaseImp(this._repository);
  final HomeRepository _repository;

  @override
  Future<Result<List<GameEntity>, GetFavoriteGamesError>> call() async {
    return await _repository.getFavoriteGames();
  }
}
