import 'package:infinitywords/modules/home/domain/errors/home_errors.dart';

abstract class HomeState {}

class InitialHomeState extends HomeState {}

class ErrorStartCreateGameState extends HomeState {
  ErrorStartCreateGameState(this.error);
  final HomeError error;
}
