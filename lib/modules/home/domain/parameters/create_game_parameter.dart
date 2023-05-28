import 'package:infinitywords/modules/home/domain/enums/dificult_enum.dart';

class CreateGameParameter {
  final String input;
  final GameDificultEnum dificult;

  CreateGameParameter({
    required this.input,
    required this.dificult,
  });
}
