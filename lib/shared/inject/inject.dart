import 'package:get_it/get_it.dart';
import 'package:infinitywords/modules/auth/domain/repositories/auth_repository.dart';
import 'package:infinitywords/modules/auth/domain/usecases/google_sign_in.dart';
import 'package:infinitywords/modules/auth/infra/repositories/auth_repository_imp.dart';
import 'package:infinitywords/modules/auth/presenter/blocs/bloc/sign_in_bloc.dart';
import 'package:infinitywords/modules/home/domain/repositories/home_repository.dart';
import 'package:infinitywords/modules/home/domain/usecases/create_game_usecase.dart';
import 'package:infinitywords/modules/home/domain/usecases/get_favorite_games_usecase.dart';
import 'package:infinitywords/modules/home/domain/usecases/get_recent_games_usecase.dart';
import 'package:infinitywords/modules/home/domain/usecases/start_create_game_usecase.dart';
import 'package:infinitywords/modules/home/infra/repositories/home_repository.dart';
import 'package:infinitywords/modules/home/presenter/blocs/blocs/create_game_bloc.dart';
import 'package:infinitywords/modules/home/presenter/blocs/blocs/home_bloc.dart';

class Inject {
  final getIt = GetIt.I;
  Inject._() {
    /// Auth module
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp());
    getIt.registerLazySingleton<GoogleSignInUsecase>(
        () => GoogleSignInUsecaseImp(getIt()));
    getIt.registerLazySingleton<SignInBloc>(() => SignInBloc(getIt(), getIt()));

    /// Home module
    getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImp());
    getIt.registerLazySingleton<StartCreateGameUsecase>(
      () => StartCreateGameUsecaseImp(),
    );
    getIt.registerLazySingleton<CreateGameUsecase>(
      () => CreateGameUsecaseImp(getIt()),
    );
    getIt.registerLazySingleton<GetFavoriteGamesUsecase>(
      () => GetFavoriteGamesUsecaseImp(getIt()),
    );
    getIt.registerLazySingleton<GetRecentGamesUsecase>(
      () => GetRecentGamesUsecaseImp(getIt()),
    );
    getIt.registerLazySingleton<HomeBloc>(
      () => HomeBloc(
        startCreateGameUsecase: getIt(),
        getFavoriteGamesUsecase: getIt(),
        getRecentGamesUsecase: getIt(),
      ),
    );
    getIt.registerLazySingleton<CreateGameBloc>(
      () => CreateGameBloc(createGameUsecase: getIt()),
    );
  }

  factory Inject.initialize() {
    return Inject._();
  }
}
