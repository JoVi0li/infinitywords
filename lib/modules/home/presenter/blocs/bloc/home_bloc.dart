import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:infinitywords/modules/home/domain/parameters/create_game_parameter.dart';
import 'package:infinitywords/modules/home/domain/usecase/create_game_usecase.dart';
import 'package:infinitywords/modules/home/domain/usecase/get_favorite_games_usecase.dart';
import 'package:infinitywords/modules/home/domain/usecase/get_recent_games_usecase.dart';
import 'package:infinitywords/modules/home/presenter/blocs/enums/welcome_message_enum.dart';
import 'package:infinitywords/modules/home/presenter/blocs/events/create_game_event.dart';
import 'package:infinitywords/modules/home/presenter/blocs/events/get_favorite_games_event.dart';
import 'package:infinitywords/modules/home/presenter/blocs/events/get_recent_games_event.dart';
import 'package:infinitywords/modules/home/presenter/blocs/events/home_event.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/create_game_state.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/get_favorite_games_state.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/get_recent_games_state.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/home_state.dart';
import 'package:infinitywords/shared/routes/home_routes.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required CreateGameUsecase createGameUsecase,
    required GetFavoriteGamesUsecase getFavoriteGamesUsecase,
    required GetRecentGamesUsecase getRecentGamesUsecase,
  }) : super(InitialHomeState()) {
    _createGameUsecase = createGameUsecase;
    _getFavoriteGamesUsecase = getFavoriteGamesUsecase;
    _getRecentGamesUsecase = getRecentGamesUsecase;
    formKey = GlobalKey();
    inputController = TextEditingController();
    on<GetFavoriteGamesEvent>(handleGetFavoriteGamesEvent);
    on<GetRecentGamesEvent>(handleGetRecentGamesEvent);
    on<CreateGameEvent>(handleCreateGameEvent);
  }

  late final CreateGameUsecase _createGameUsecase;
  late final GetFavoriteGamesUsecase _getFavoriteGamesUsecase;
  late final GetRecentGamesUsecase _getRecentGamesUsecase;

  late final GlobalKey<FormState> formKey;
  late final TextEditingController inputController;

  String get welcomeMessage {
    final hour = DateTime.now().hour;

    if (hour >= 0 && hour < 12) return WelcomeMessageEnum.goodMorning.value;

    if (hour >= 12 && hour < 18) return WelcomeMessageEnum.goodAfternoon.value;

    return WelcomeMessageEnum.goodNight.value;
  }

  Future<void> handleCreateGameEvent(
    CreateGameEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (!formKey.currentState!.validate()) return;
    
    final createGameParameter = CreateGameParameter(event.input);

    final result = _createGameUsecase(createGameParameter);

    result.when(
      (success) async => await navigateToCreateGamePage(event.context),
      (error) => emit(ErrorCreateGameState(error)),
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

  Future<void> navigateToCreateGamePage(BuildContext context) async {
    return await Navigator.pushNamed<void>(context, HomeRoutes.createGame);
  }

  String? inputValidator(String? value) {
    if (value == null) return 'Informe um tópico válido';
    if (value.isEmpty) return 'Informe um tópico válido';
    if (value.length < 3) return 'O tópico deve conter no mínimo 4 caracteres';
    return null;
  }
}
