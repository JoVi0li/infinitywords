import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';

extension GameEntityMapper on GameEntity {
  GameEntity fromMap(Map<String, dynamic> json) {
    return GameEntity(
      topic: json['topic'],
      dificult: json['dificult'],
    );
  }

  Map<String, String> toJson() {
    return {
      'topic': topic,
      'dificult': dificult.value,
    };
  }
}
