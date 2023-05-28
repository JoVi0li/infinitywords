import 'package:infinitywords/modules/home/domain/errors/home_errors.dart';
import 'package:infinitywords/modules/home/domain/parameters/start_create_game_parameter.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class StartCreateGameUsecase {
  Result<String, HomeError> call(StartCreateGameParameter parameter);
}

class StartCreateGameUsecaseImp implements StartCreateGameUsecase {
  @override
  Result<String, HomeError> call(StartCreateGameParameter parameter) {
    final input = parameter.input;

    if (input.isEmpty) {
      return Error(HomeError.genericError(
        message: 'Informe um assunto válido',
        error: 'Assunto inválido',
      ));
    }

    if (input.length < 3) {
      return Error(HomeError.genericError(
        message: 'Informe um assunto válido',
        error: 'Assunto inválido',
      ));
    }

    return Success(input);
  }
}
