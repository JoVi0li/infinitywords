import 'package:infinitywords/modules/home/domain/enums/dificult_enum.dart';

class GameEntity {
  final String id;
  final String topic;
  final List<String> words;
  final GameDificultEnum dificult;

  GameEntity({
    required this.id,
    required this.topic,
    required this.words,
    required this.dificult,
  });

  factory GameEntity.fromJson(Map<String, dynamic> json) {
    return GameEntity(
      id: json['id'],
      topic: json['topic'],
      words: json['words'],
      dificult: json['dificult'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topic': topic,
      'words': words,
      'dificult': dificult,
    };
  }
}
