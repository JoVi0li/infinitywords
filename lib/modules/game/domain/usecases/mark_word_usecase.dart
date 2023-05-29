import 'package:infinitywords/modules/game/domain/errors/game_errors.dart';
import 'package:infinitywords/modules/game/domain/repositories/game_repository.dart';
import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class MarkWordUsecase {
  Result<void, GameError> call(String word, GameEntity currentGame);
}

class MarkWordUsecaseImp implements MarkWordUsecase {
  MarkWordUsecaseImp(this._repository);
  final GameRepository _repository;

  @override
  Result<void, GameError> call(String word, GameEntity currentGame) {
    return _repository.markWord(word, currentGame);
  }
}
