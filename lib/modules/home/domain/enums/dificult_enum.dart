enum GameDificultEnum {
  easy('easy', 'Fácil'),
  normal('normal', 'Normal'),
  hard('hard', 'Difícil');

  final String value;
  final String translatedValue;
  const GameDificultEnum(
    this.value,
    this.translatedValue,
  );
}
