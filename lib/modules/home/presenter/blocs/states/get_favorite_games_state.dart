import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';
import 'package:infinitywords/modules/home/domain/errors/get_favorite_games_errors.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/home_state.dart';

abstract class GetFavoriteGamesState extends HomeState {}

class LoadingGetFavoriteGamesState extends HomeState {}

class SuccessGetFavoriteGamesState extends HomeState {
  SuccessGetFavoriteGamesState(this.games);
  final List<GameEntity> games;
}

class ErrorGetFavoriteGamesState extends HomeState {
  ErrorGetFavoriteGamesState(this.error);
  final GetFavoriteGamesError error;
}
