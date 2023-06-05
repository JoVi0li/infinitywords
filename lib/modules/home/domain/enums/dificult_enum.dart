enum GameDificultEnum {
  easy('easy', 'Fácil', [
    WordShuffle.leftRight,
    WordShuffle.topBottom,
  ]),
  normal('normal', 'Normal', [
    WordShuffle.leftRight,
    WordShuffle.topBottom,
    WordShuffle.crossToRight,
  ]),
  hard('hard', 'Difícil', [
    WordShuffle.leftRight,
    WordShuffle.topBottom,
    WordShuffle.crossToRight,
    WordShuffle.crossToLeft,
  ]);

  final String value;
  final String translatedValue;
  final List<WordShuffle> wordsShuffle;
  const GameDificultEnum(
    this.value,
    this.translatedValue,
    this.wordsShuffle,
  );
}

enum WordShuffle {
  leftRight,
  topBottom,
  crossToRight,
  crossToLeft,
}
