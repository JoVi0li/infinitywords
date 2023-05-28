import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinitywords/modules/home/presenter/blocs/blocs/create_game_bloc.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/create_game/create_game_state.dart';
import 'package:infinitywords/shared/widgets/message_widget.dart';

class LoadingGameScreen extends StatefulWidget {
  const LoadingGameScreen({super.key});

  @override
  State<LoadingGameScreen> createState() => _LoadingGameScreenState();
}

class _LoadingGameScreenState extends State<LoadingGameScreen> {
  final _getIt = GetIt.I;
  late final CreateGameBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = _getIt<CreateGameBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 90,
          bottom: 0,
        ),
        child: BlocListener<CreateGameBloc, CreateGameState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is SuccessCreateGameState) {
              _bloc.navigateToGamePage(context, state.game);
            }

            if (state is ErrorCreateGameState) {
              showDialog(
                context: context,
                builder: (ctx) => MessageWidget(
                  title: state.error.error,
                  message: state.error.message,
                ),
              );
              Navigator.pop(context);
            }
          },
          child: Text(
            'Criando\nnovo jogo...',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
