import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';
import 'package:infinitywords/modules/home/domain/errors/get_recent_games_errors.dart';
import 'package:infinitywords/modules/home/domain/repositories/home_repository.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class GetRecentGamesUsecase {
  Future<Result<List<GameEntity>, GetRecentGamesError>> call();
}

class GetRecentGamesUsecaseImp implements GetRecentGamesUsecase {
  GetRecentGamesUsecaseImp(this._repository);
  final HomeRepository _repository;

  @override
  Future<Result<List<GameEntity>, GetRecentGamesError>> call() async {
    return await _repository.getRecentGames();
  }
}
