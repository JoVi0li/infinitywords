import 'package:infinitywords/modules/home/domain/enums/dificult_enum.dart';

abstract class CreateGamePrompts {
  static String prompt({
    required String topic,
    required GameDificultEnum dificult,
  }) {
    switch (dificult) {
      case GameDificultEnum.easy:
        return "Traga uma lista de 5 palavras sobre $topic. Retorne apenas a lista, sem enumeração, uma ao lado da outra, separadas apenas por um espaço. As palavras devem ter tamanho máximo de 10 letras, não devem remeter a contextos polêmicos, e devem ser retirados quaisquer acentos e pontuações das palavras.";
      case GameDificultEnum.normal:
        return "Traga uma lista de 10 palavras sobre $topic. Retorne apenas a lista, sem enumeração, uma ao lado da outra, separadas apenas por um espaço. As palavras devem ter tamanho máximo de 10 letras, não devem remeter a contextos polêmicos, e devem ser retirados quaisquer acentos e pontuações das palavras.";
      case GameDificultEnum.hard:
        return "Traga uma lista de 15 palavras sobre $topic. Retorne apenas a lista, sem enumeração, uma ao lado da outra, separadas apenas por um espaço. As palavras devem ter tamanho máximo de 10 letras, não devem remeter a contextos polêmicos, e devem ser retirados quaisquer acentos e pontuações das palavras.";
    }
  }
}
