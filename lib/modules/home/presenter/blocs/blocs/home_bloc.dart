import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:infinitywords/modules/home/domain/parameters/start_create_game_parameter.dart';
import 'package:infinitywords/modules/home/domain/usecases/start_create_game_usecase.dart';
import 'package:infinitywords/modules/home/domain/usecases/get_favorite_games_usecase.dart';
import 'package:infinitywords/modules/home/domain/usecases/get_recent_games_usecase.dart';
import 'package:infinitywords/modules/home/presenter/blocs/enums/welcome_message_enum.dart';
import 'package:infinitywords/modules/home/presenter/blocs/events/home/get_favorite_games_event.dart';
import 'package:infinitywords/modules/home/presenter/blocs/events/home/start_create_game_event.dart';
import 'package:infinitywords/modules/home/presenter/blocs/events/home/get_recent_games_event.dart';
import 'package:infinitywords/modules/home/presenter/blocs/events/home/home_event.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/home/get_favorite_games_state.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/home/get_recent_games_state.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/home/home_state.dart';
import 'package:infinitywords/shared/routes/home_routes.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required StartCreateGameUsecase startCreateGameUsecase,
    required GetFavoriteGamesUsecase getFavoriteGamesUsecase,
    required GetRecentGamesUsecase getRecentGamesUsecase,
  }) : super(InitialHomeState()) {
    _startCreateGameUsecase = startCreateGameUsecase;
    _getFavoriteGamesUsecase = getFavoriteGamesUsecase;
    _getRecentGamesUsecase = getRecentGamesUsecase;
    formKey = GlobalKey();
    inputController = TextEditingController();
    inputFocus = FocusNode();
    on<GetFavoriteGamesEvent>(handleGetFavoriteGamesEvent);
    on<GetRecentGamesEvent>(handleGetRecentGamesEvent);
    on<StartCreateGameEvent>(handleCreateGameEvent);
  }

  late final StartCreateGameUsecase _startCreateGameUsecase;
  late final GetFavoriteGamesUsecase _getFavoriteGamesUsecase;
  late final GetRecentGamesUsecase _getRecentGamesUsecase;

  late final GlobalKey<FormState> formKey;
  late final TextEditingController inputController;

  late final FocusNode inputFocus;

  String get welcomeMessage {
    final hour = DateTime.now().hour;

    if (hour >= 0 && hour < 12) return WelcomeMessageEnum.goodMorning.value;

    if (hour >= 12 && hour < 18) return WelcomeMessageEnum.goodAfternoon.value;

    return WelcomeMessageEnum.goodNight.value;
  }

  Future<void> handleCreateGameEvent(
    StartCreateGameEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (!formKey.currentState!.validate()) return;

    final createGameParameter = StartCreateGameParameter(event.input);

    final result = _startCreateGameUsecase(createGameParameter);

    result.when(
      (input) async => await navigateToCreateGamePage(event.context, input),
      (error) => emit(ErrorStartCreateGameState(error)),
    );
  }

  Future<void> handleGetFavoriteGamesEvent(
    GetFavoriteGamesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(LoadingGetFavoriteGamesState());

    final result = await _getFavoriteGamesUsecase();

    result.when(
      (games) => emit(SuccessGetFavoriteGamesState(games)),
      (error) => emit(ErrorGetFavoriteGamesState(error)),
    );
  }

  Future<void> handleGetRecentGamesEvent(
    GetRecentGamesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(LoadingGetRecentGamesState());

    final result = await _getRecentGamesUsecase();

    result.when(
      (games) => emit(SuccessGetRecentGamesState(games)),
      (error) => emit(ErrorGetRecentGamesState(error)),
    );
  }

  Future<void> navigateToCreateGamePage(
    BuildContext context,
    String input,
  ) async {
    return await Navigator.pushNamed<void>(
      context,
      HomeRoutes.createGame,
      arguments: {'input': input},
    );
  }

  String? inputValidator(String? value) {
    if (value == null) return 'Informe um tópico válido';
    if (value.isEmpty) return 'Informe um tópico válido';
    if (value.length < 3) return 'O tópico deve conter no mínimo 4 caracteres';
    return null;
  }
}
