import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';
import 'package:infinitywords/modules/home/domain/errors/get_recent_games_errors.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/home_state.dart';

abstract class GetRecentGamesState extends HomeState {}

class LoadingGetRecentGamesState extends HomeState {}

class SuccessGetRecentGamesState extends HomeState {
  SuccessGetRecentGamesState(this.games);
  final List<GameEntity> games;
}

class ErrorGetRecentGamesState extends HomeState {
  ErrorGetRecentGamesState(this.error);
  final GetRecentGamesError error;
}
