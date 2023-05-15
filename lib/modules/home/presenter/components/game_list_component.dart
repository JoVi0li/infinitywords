import 'package:flutter/material.dart';
import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';

class GameListComponent extends StatelessWidget {
  const GameListComponent({
    super.key,
    required this.games,
    required this.isLoading,
  });

  final List<GameEntity> games;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
          child: CircularProgressIndicator(
        color: Color(0xFF313040),
      ));
    }
    if (games.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.list,
              color: Colors.white,
              size: 36,
            ),
            const SizedBox(height: 8),
            Text(
              'Ops, parece que\nestá tudo vazio por aqui.',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: games.length,
      itemBuilder: (context, index) => Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            tileColor: const Color(0xFF313040),
            dense: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              side: BorderSide(color: Colors.white),
            ),
            title: Text(
              games[index].topic,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              'Dificuldade: ${games[index].dificult.value}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
