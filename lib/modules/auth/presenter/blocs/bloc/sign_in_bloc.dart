import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:infinitywords/modules/auth/domain/errors/google_sign_in_errors.dart';
import 'package:infinitywords/modules/auth/domain/repositories/auth_repository.dart';
import 'package:infinitywords/modules/auth/domain/usecases/google_sign_in.dart';
import 'package:infinitywords/modules/auth/presenter/blocs/events/sign_in_event.dart';
import 'package:infinitywords/modules/auth/presenter/blocs/states/sign_in_state.dart';
import 'package:infinitywords/shared/routes/home_routes.dart';
import 'package:infinitywords/shared/widgets/message_widget.dart';
import 'dart:io' show Platform;

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final GoogleSignInUsecase _usecase;
  final AuthRepository _repository;
  SignInBloc(this._usecase, this._repository) : super(InitialSignInState()) {
    on<GoogleSignInEvent>(_handleGoogleSignInEvent);
  }

  void checkAuthStatus(BuildContext context) {
    _repository.checkAuthState((user) async {
      if (user == null) return;

      await Navigator.pushNamedAndRemoveUntil(
        context,
        HomeRoutes.home,
        (route) => false,
      );
    });
  }

  Future<void> _handleGoogleSignInEvent(
    GoogleSignInEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(LoadingSignInState());

    final result = await _usecase();

    result.when(
      (success) => emit(SuccessSignInState()),
      (error) => emit(ErrorSignInState.googleError(error)),
    );
  }

  void signIn() {
    if (Platform.isAndroid) {
      add(GoogleSignInEvent());
    } else if (Platform.isIOS) {
      // TODO: Implements IOS signIn
    }
  }

  void handleListener(BuildContext ctx, SignInState state) {
    if (state is InitialSignInState) return;

    if (state is LoadingSignInState) return;

    if (state is ErrorSignInState) {
      showErrorMessage(state.googleError!, ctx);
    }

    if (state is SuccessSignInState) {}
  }

  Future<void> showErrorMessage(
    GoogleSignInError error,
    BuildContext context,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => MessageWidget(
        title: error.error,
        message: error.message ?? '',
      ),
    );
  }
}
