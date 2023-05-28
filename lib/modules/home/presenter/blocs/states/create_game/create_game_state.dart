import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';
import 'package:infinitywords/modules/home/domain/errors/home_errors.dart';

abstract class CreateGameState {}

class InitialCreateGameState extends CreateGameState {}

class LoadingCreateGameState extends CreateGameState {}

class ErrorCreateGameState extends CreateGameState {
  ErrorCreateGameState(this.error);
  final HomeError error;
}

class SuccessCreateGameState extends CreateGameState {
  SuccessCreateGameState(this.game);
  final GameEntity game;
}
