import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:infinitywords/modules/game/domain/usecases/favorite_game_usecase.dart';
import 'package:infinitywords/modules/game/domain/usecases/mark_word_usecase.dart';
import 'package:infinitywords/modules/game/domain/usecases/unfavorite_game_usecase.dart';
import 'package:infinitywords/modules/game/presenter/blocs/events/game_event.dart';
import 'package:infinitywords/modules/game/presenter/blocs/states/game_state.dart';
import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';
import 'package:infinitywords/shared/routes/home_routes.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc({
    required MarkWordUsecase markWordUsecase,
    required FavoriteGameUsecase favoriteGameUsecase,
    required UnfavoriteGameUsecase unfavoriteGameUsecase,
  }) : super(InitialGameState()) {
    _markWordUsecase = markWordUsecase;
    _favoriteGameUsecase = favoriteGameUsecase;
    _unfavoriteGameUsecase = unfavoriteGameUsecase;
    on<MarkWordGameEvent>(handleMarkWordEvent);
    on<ChangeFavoriteGameStatus>(handleChangeFavoriteGameEvent);
  }

  late final MarkWordUsecase _markWordUsecase;
  late final FavoriteGameUsecase _favoriteGameUsecase;
  late final UnfavoriteGameUsecase _unfavoriteGameUsecase;
  late GameEntity game;

  void initCurrentGameValue(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as GameEntity;
    game = arg;
  }

  void handleMarkWordEvent(
    MarkWordGameEvent event,
    Emitter<GameState> emit,
  ) {
    final result = _markWordUsecase(event.word, game);

    result.when(
      (success) => emit(SuccessfullyMarkedWordState(event.word)),
      (error) => emit(ErrorGameState(error)),
    );
  }

  Future<void> handleChangeFavoriteGameEvent(
    ChangeFavoriteGameStatus event,
    Emitter<GameState> emit,
  ) async {
    if (event.isFavorite) {
      final result = await _favoriteGameUsecase(game.id);

      result.when(
        (success) => emit(SuccessfullyChangedFavoriteGameStatus()),
        (error) => emit(ErrorGameState(error)),
      );
    } else {
      final result = await _unfavoriteGameUsecase(game.id);

      result.when(
        (success) => emit(SuccessfullyChangedFavoriteGameStatus()),
        (error) => emit(ErrorGameState(error)),
      );
    }
  }

  Future<void> navigateToHome(BuildContext context) async {
    return await Navigator.pushNamedAndRemoveUntil<void>(
      context,
      HomeRoutes.home,
      (route) => false,
    );
  }
}
