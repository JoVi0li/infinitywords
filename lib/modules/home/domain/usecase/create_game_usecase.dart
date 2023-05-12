import 'package:infinitywords/modules/home/domain/errors/home_errors.dart';
import 'package:infinitywords/modules/home/domain/parameters/create_game_parameter.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class CreateGameUsecase {
  Result<String, HomeError> call(CreateGameParameter parameter);
}

class CreateGameUsecaseImp implements CreateGameUsecase {
  @override
  Result<String, HomeError> call(CreateGameParameter parameter) {
    final input = parameter.input;

    if (input.isEmpty) {
      return Error(GenericHomeError(
        message: 'Informe um assunto válido',
        error: 'Assunto inválido',
      ));
    }

    if (input.length < 3) {
      return Error(GenericHomeError(
        message: 'Informe um assunto válido',
        error: 'Assunto inválido',
      ));
    }

    return Success(input);
  }
}
