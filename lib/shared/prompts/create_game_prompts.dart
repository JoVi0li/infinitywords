import 'package:infinitywords/modules/home/domain/enums/dificult_enum.dart';

abstract class CreateGamePrompts {
  static String call({
    required String topic,
    required GameDificultEnum dificult,
  }) {
    switch (dificult) {
      case GameDificultEnum.easy:
        return "Traga uma lista de 5 palavras sobre $topic. Retorne apenas a lista.";
      case GameDificultEnum.normal:
        return "Traga uma lista de 10 palavras sobre $topic. Retorne apenas a lista.";
      case GameDificultEnum.hard:
        return "Traga uma lista de 15 palavras sobre $topic. Retorne apenas a lista.";
    }
  }
}
