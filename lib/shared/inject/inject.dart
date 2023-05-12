import 'package:get_it/get_it.dart';
import 'package:infinitywords/modules/auth/domain/repositories/auth_repository.dart';
import 'package:infinitywords/modules/auth/domain/usecases/google_sign_in.dart';
import 'package:infinitywords/modules/auth/infra/repositories/auth_repository_imp.dart';
import 'package:infinitywords/modules/auth/presenter/blocs/bloc/sign_in_bloc.dart';

class Inject {
  final getIt = GetIt.I;
  Inject._() {
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp());
    getIt.registerLazySingleton<GoogleSignInUsecase>(() => GoogleSignInUsecaseImp(getIt()));
    getIt.registerLazySingleton<SignInBloc>(() => SignInBloc(getIt(), getIt()));
  }

  factory Inject.initialize() {
    return Inject._();
  }
}
