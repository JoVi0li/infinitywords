import 'package:infinitywords/modules/home/domain/errors/home_errors.dart';
import 'package:infinitywords/modules/home/domain/responses/get_games_response.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/home/home_state.dart';

abstract class GetRecentGamesState extends HomeState {}

class LoadingGetRecentGamesState extends HomeState {}

class SuccessGetRecentGamesState extends HomeState {
  SuccessGetRecentGamesState(this.games);
  final GetGamesResponse games;
}

class ErrorGetRecentGamesState extends HomeState {
  ErrorGetRecentGamesState(this.error);
  final HomeError error;
}
