import 'package:infinitywords/modules/home/domain/entities/historic_game_entity.dart';

class GetGamesResponse {
  GetGamesResponse(this.historicGames);
  final List<HistoricGameEntity> historicGames;
}
