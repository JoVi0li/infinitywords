import 'package:infinitywords/modules/game/domain/errors/game_errors.dart';
import 'package:infinitywords/modules/game/domain/repositories/game_repository.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class UnfavoriteGameUsecase {
  Future<Result<void, GameError>> call(String gameId);
}

class UnfavoriteGameUsecaseImp implements UnfavoriteGameUsecase {
  UnfavoriteGameUsecaseImp(this._repository);
  final GameRepository _repository;

  @override
  Future<Result<void, GameError>> call(String gameId) async {
    return await _repository.changeFavoriteGameStatus(false, gameId);
  }
}
