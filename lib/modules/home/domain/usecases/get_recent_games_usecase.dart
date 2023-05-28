import 'package:infinitywords/modules/home/domain/errors/home_errors.dart';
import 'package:infinitywords/modules/home/domain/repositories/home_repository.dart';
import 'package:infinitywords/modules/home/domain/responses/get_games_response.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class GetRecentGamesUsecase {
  Future<Result<GetGamesResponse, HomeError>> call();
}

class GetRecentGamesUsecaseImp implements GetRecentGamesUsecase {
  GetRecentGamesUsecaseImp(this._repository);
  final HomeRepository _repository;

  @override
  Future<Result<GetGamesResponse, HomeError>> call() async {
    return await _repository.getRecentGames();
  }
}
