abstract class GameEvent {}

class MarkWordGameEvent extends GameEvent {
  MarkWordGameEvent(this.word);
  final String word;
}

class ChangeFavoriteGameStatus extends GameEvent {
  ChangeFavoriteGameStatus(this.isFavorite);
  final bool isFavorite;
}
