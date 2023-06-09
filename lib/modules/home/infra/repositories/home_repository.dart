import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_openai/openai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';
import 'package:infinitywords/modules/home/domain/entities/historic_game_entity.dart';
import 'package:infinitywords/modules/home/domain/errors/home_errors.dart';
import 'package:infinitywords/modules/home/domain/parameters/create_game_parameter.dart';
import 'package:infinitywords/modules/home/domain/repositories/home_repository.dart';
import 'package:infinitywords/modules/home/domain/responses/get_games_response.dart';
import 'package:infinitywords/modules/home/domain/responses/create_game_response.dart';
import 'package:infinitywords/shared/prompts/create_game_prompts.dart';
import 'package:multiple_result/multiple_result.dart';

class HomeRepositoryImp implements HomeRepository {
  @override
  Future<Result<CreateGameResponse, HomeError>> createGame(
    CreateGameParameter parameter,
  ) async {
    try {
      final words = await OpenAI.instance.chat.create(
        model: 'gpt-3.5-turbo',
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.user,
            content: CreateGamePrompts.call(
              topic: parameter.input,
              dificult: parameter.dificult,
            ),
          ),
        ],
      ).then((value) => value.choices[0].message.content.split(" "));

      final result = await FirebaseFirestore.instance.collection('games').add({
        'topic': parameter.input,
        'dificult': parameter.dificult.value,
        'words': words
      });

      return Success(
        CreateGameResponse(
          GameEntity(
            id: result.id,
            topic: parameter.input,
            words: words,
            dificult: parameter.dificult,
          ),
        ),
      );
    } on FirebaseException catch (e) {
      return Error(HomeError.firebaseError(e));
    } on RequestFailedException catch (e) {
      return Error(HomeError.openAIError(e));
    }
  }

  @override
  Future<Result<GetGamesResponse, HomeError>> getFavoriteGames() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return Error(UnauthenticateUser());

      final favoriteGamesSnapshot = await FirebaseFirestore.instance
          .collection('historic')
          .where('userId', isEqualTo: user.uid)
          .where('isFavorite', isEqualTo: true)
          // .orderBy('createdAt', descending: true)
          .get();

      if (favoriteGamesSnapshot.docs.isEmpty) {
        return Success(GetGamesResponse([]));
      }

      final favoriteGames = favoriteGamesSnapshot.docs
          .map((e) => HistoricGameEntity.fromJson(e.data()))
          .toList();

      return Success(GetGamesResponse(favoriteGames));
    } on FirebaseException catch (e) {
      return Error(HomeError.firebaseError(e));
    } on RequestFailedException catch (e) {
      return Error(HomeError.openAIError(e));
    }
  }

  @override
  Future<Result<GetGamesResponse, HomeError>> getRecentGames() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return Error(UnauthenticateUser());

      final recentGamesSnapshot = await FirebaseFirestore.instance
          .collection('historic')
          .where('userId', isEqualTo: user.uid)
          // .orderBy('createdAt', descending: true)
          .limit(10)
          .get();

      if (recentGamesSnapshot.docs.isEmpty) {
        return Success(GetGamesResponse([]));
      }

      final recentGames = recentGamesSnapshot.docs
          .map((e) => HistoricGameEntity.fromJson(e.data()))
          .toList();

      return Success(GetGamesResponse(recentGames));
    } on FirebaseException catch (e) {
      return Error(HomeError.firebaseError(e));
    } on RequestFailedException catch (e) {
      return Error(HomeError.openAIError(e));
    }
  }
}
