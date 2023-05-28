import 'package:infinitywords/modules/home/domain/enums/dificult_enum.dart';

abstract class CreateGameEvent {}

class NewCreateGameEvent extends CreateGameEvent {
  NewCreateGameEvent({required this.dificult});
  final GameDificultEnum dificult;
}
