import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_openai/openai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:infinitywords/modules/home/domain/errors/create_game_errors.dart';
import 'package:infinitywords/modules/home/domain/errors/get_recent_games_errors.dart';
import 'package:infinitywords/modules/home/domain/errors/get_favorite_games_errors.dart';
import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';
import 'package:infinitywords/modules/home/domain/parameters/create_game_parameter.dart';
import 'package:infinitywords/modules/home/domain/repositories/home_repository.dart';
import 'package:infinitywords/modules/home/infra/mappers/game_entity_mapper.dart';
import 'package:multiple_result/multiple_result.dart';

class HomeRepositoryImp implements HomeRepository {
  HomeRepositoryImp() {
    _database = FirebaseFirestore.instance;
  }
  late final FirebaseFirestore _database;

  @override
  Future<Result<List<GameEntity>, GetFavoriteGamesError>>
      getFavoriteGames() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return Error(UnauthenticateUserGetFavoriteGamesError());

      final userId = user.uid;

      final ref = await _database.collection('users/$userId/favorites').get();

      final games = ref.docs
          .map((game) => GameEntityMapper.fromMap(game.data()))
          .toList();

      return Success(games);
    } on FirebaseException catch (e) {
      return Error(GenericGetFavoriteGamesError(
        code: e.code,
        message: e.message,
        error: 'Algo deu errado',
      ));
    }
  }

  @override
  Future<Result<List<GameEntity>, GetRecentGamesError>> getRecentGames() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return Error(UnauthenticateUserGetRecentGamesError());

      final userId = user.uid;

      final ref =
          await _database.collection('users/$userId/historic').limit(10).get();

      final games = ref.docs
          .map((game) => GameEntityMapper.fromMap(game.data()))
          .toList();

      return Success(games);
    } on FirebaseException catch (e) {
      return Error(GenericGetRecentGamesError(
        code: e.code,
        message: e.message,
        error: 'Algo deu errado',
      ));
    }
  }

  @override
  Future<Result<String, CreateGameBaseError>> createGame(
    CreateGameParameter parameter,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return const Error(UnauthenticateUserCreateGameFirebaseError());
      }

      final userId = user.uid;

      final ref = _database.collection('games');

      final game = GameEntity(
        topic: parameter.input,
        dificult: parameter.dificult,
      );

      final chatCompletion = await OpenAI.instance.chat.create(
        model: 'model-3.5-turbo',
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.user,
            content: game.topic,
          ),
        ],
      );
      
    } catch (e) {}
    throw UnimplementedError();
  }
}
