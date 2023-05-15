import 'package:infinitywords/modules/home/domain/errors/home_errors.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/home_state.dart';

class InitialCreateGameState extends HomeState {}

class ErrorCreateGameState extends HomeState {
  ErrorCreateGameState(this.error);
  final HomeError error;
}
