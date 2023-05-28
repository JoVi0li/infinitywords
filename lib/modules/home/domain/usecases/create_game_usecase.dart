import 'package:infinitywords/modules/home/domain/errors/home_errors.dart';
import 'package:infinitywords/modules/home/domain/parameters/create_game_parameter.dart';
import 'package:infinitywords/modules/home/domain/repositories/home_repository.dart';
import 'package:infinitywords/modules/home/domain/responses/create_game_response.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class CreateGameUsecase {
  Future<Result<CreateGameResponse, HomeError>> call(
    CreateGameParameter parameter,
  );
}

class CreateGameUsecaseImp implements CreateGameUsecase {
  CreateGameUsecaseImp(this._repository);
  final HomeRepository _repository;

  @override
  Future<Result<CreateGameResponse, HomeError>> call(
    CreateGameParameter parameter,
  ) async {
    return await _repository.createGame(parameter);
  }
}
