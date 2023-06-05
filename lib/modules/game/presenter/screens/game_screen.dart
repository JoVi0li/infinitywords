import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infinitywords/modules/game/presenter/blocs/blocs/game_bloc.dart';
import 'package:infinitywords/modules/game/presenter/components/word_board_component.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final getIt = GetIt.I;
  late final GameBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<GameBloc>();
  }

  @override
  void dispose() {
    getIt.resetLazySingleton<GameBloc>();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.initCurrentGameValue(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            Text(
              _bloc.game.topic,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              _bloc.game.dificult.translatedValue,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 32,
                height: MediaQuery.of(context).size.height / 2,
                child: CustomPaint(
                  painter: WordBoardComponent(
                    context,
                    game: _bloc.game,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
