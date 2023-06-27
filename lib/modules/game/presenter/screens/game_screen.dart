import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:infinitywords/modules/game/presenter/blocs/blocs/game_bloc.dart';
import 'package:infinitywords/modules/game/presenter/blocs/events/game_event.dart';
import 'package:infinitywords/modules/game/presenter/components/word_board_component.dart';
import 'package:infinitywords/modules/game/presenter/components/word_list_component.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final getIt = GetIt.I;
  late final GameBloc _bloc;
  bool isFavorite = false;

  ValueNotifier<Offset> selectedWord = ValueNotifier(const Offset(0, 0));

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

  addChangeFavoriteGameStatus(bool isFavorite) {
    _bloc.add(ChangeFavoriteGameStatus(isFavorite));
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
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
              addChangeFavoriteGameStatus(isFavorite);
            },
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 32,
              height: MediaQuery.of(context).size.height / 2,
              child: GestureDetector(
                onHorizontalDragStart: (details) {
                  setState(() {
                    final offset = Offset(
                      details.localPosition.dx -
                          (details.localPosition.dx % 20),
                      details.localPosition.dy -
                          (details.localPosition.dy % 20),
                    );

                    selectedWord.value = offset;
                  });
                },
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    final offset = Offset(
                      details.localPosition.dx -
                          (details.localPosition.dx % 20),
                      details.localPosition.dy -
                          (details.localPosition.dy % 20),
                    );

                    selectedWord.value = offset;
                  });
                },
                onVerticalDragStart: (details) {},
                onVerticalDragUpdate: (details) {},
                onHorizontalDragEnd: (details) {},
                child: CustomPaint(
                  painter: WordBoardComponent(
                    context,
                    game: _bloc.game,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: WordListComponent(words: _bloc.game.words),
            ),
          ),
        ],
      ),
    );
  }
}
