import 'package:infinitywords/modules/home/domain/errors/home_errors.dart';
import 'package:infinitywords/modules/home/domain/parameters/create_game_parameter.dart';
import 'package:infinitywords/modules/home/domain/responses/create_game_response.dart';
import 'package:infinitywords/modules/home/domain/responses/get_games_response.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class HomeRepository {
  Future<Result<GetGamesResponse, HomeError>> getRecentGames();
  Future<Result<GetGamesResponse, HomeError>> getFavoriteGames();
  Future<Result<CreateGameResponse, HomeError>> createGame(
    CreateGameParameter parameter,
  );
}
