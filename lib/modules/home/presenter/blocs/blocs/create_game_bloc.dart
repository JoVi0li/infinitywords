import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';
import 'package:infinitywords/modules/home/domain/parameters/create_game_parameter.dart';
import 'package:infinitywords/modules/home/domain/usecases/create_game_usecase.dart';
import 'package:infinitywords/modules/home/presenter/blocs/events/create_game/create_game_event.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/create_game/create_game_state.dart';
import 'package:infinitywords/shared/routes/game_routes.dart';
import 'package:infinitywords/shared/routes/home_routes.dart';

class CreateGameBloc extends Bloc<CreateGameEvent, CreateGameState> {
  CreateGameBloc({
    required CreateGameUsecase createGameUsecase,
  }) : super(InitialCreateGameState()) {
    _usecase = createGameUsecase;
    formKey = GlobalKey();
    inputFocus = FocusNode();
    inputController = TextEditingController();
    on<NewCreateGameEvent>(handleNewCreateGameEvent);
  }

  late final CreateGameUsecase _usecase;

  late final GlobalKey<FormState> formKey;
  late final TextEditingController inputController;

  late final FocusNode inputFocus;

  Future<void> handleNewCreateGameEvent(
    NewCreateGameEvent event,
    Emitter<CreateGameState> emit,
  ) async {
    if (!formKey.currentState!.validate()) return;

    emit(LoadingCreateGameState());

    final result = await _usecase(CreateGameParameter(
      input: inputController.text,
      dificult: event.dificult,
    ));

    return result.when(
      (response) => emit(SuccessCreateGameState(response.game)),
      (error) => emit(ErrorCreateGameState(error)),
    );
  }

  void initTopicValue(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final input = args['input']!;
    inputController.text = input;
  }

  Future<void> navigateToGamePage(
    BuildContext context,
    GameEntity game,
  ) async {
    return Navigator.pushNamedAndRemoveUntil<void>(
      context,
      GameRoutes.game,
      (route) => false,
    );
  }

  Future<void> navigateToLoadingGamePage(BuildContext context) async {
    return await Navigator.pushNamed<void>(
      context,
      HomeRoutes.loadingGame,
    );
  }

  String? inputValidator(String? value) {
    if (value == null) return 'Informe um tópico válido';
    if (value.isEmpty) return 'Informe um tópico válido';
    if (value.length < 3) return 'O tópico deve conter no mínimo 4 caracteres';
    return null;
  }
}
