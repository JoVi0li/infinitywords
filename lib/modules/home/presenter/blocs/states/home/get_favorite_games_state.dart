import 'package:infinitywords/modules/home/domain/errors/home_errors.dart';
import 'package:infinitywords/modules/home/domain/responses/get_games_response.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/home/home_state.dart';

abstract class GetFavoriteGamesState extends HomeState {}

class LoadingGetFavoriteGamesState extends HomeState {}

class SuccessGetFavoriteGamesState extends HomeState {
  SuccessGetFavoriteGamesState(this.games);
  final GetGamesResponse games;
}

class ErrorGetFavoriteGamesState extends HomeState {
  ErrorGetFavoriteGamesState(this.error);
  final HomeError error;
}
