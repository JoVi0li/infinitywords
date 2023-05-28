import 'package:infinitywords/modules/home/domain/enums/dificult_enum.dart';

class HistoricGameEntity {
  final String id;
  final String topic;
  final GameDificultEnum dificult;
  final bool isFavorite;

  HistoricGameEntity({
    required this.id,
    required this.topic,
    required this.dificult,
    required this.isFavorite,
  });

  factory HistoricGameEntity.fromJson(Map<String, dynamic> json) {
    return HistoricGameEntity(
      id: json['id'],
      topic: json['topic'],
      dificult: json['dificult'],
      isFavorite: json['isFavorite'],
    );
  }
}
