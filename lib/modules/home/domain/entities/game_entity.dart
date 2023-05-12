import 'package:infinitywords/modules/home/domain/enums/dificult_enum.dart';

class GameEntity {
  final String topic;
  final GameDificult dificult;

  GameEntity({
    required this.topic,
    required this.dificult,
  });
}
