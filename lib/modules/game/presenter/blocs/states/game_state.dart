import 'package:infinitywords/modules/game/domain/errors/game_errors.dart';

abstract class GameState {}

class InitialGameState extends GameState {}

class LoadingGameState extends GameState {}

class SuccessGameState extends GameState {}

class ErrorGameState extends GameState {
  ErrorGameState(this.error);
  final GameError error;
}

class SuccessfullyMarkedWordState extends GameState {
  SuccessfullyMarkedWordState(this.word);
  final String word;
}

class SuccessfullyChangedFavoriteGameStatus extends GameState {}
