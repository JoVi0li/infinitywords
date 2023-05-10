import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:infinitywords/modules/auth/domain/errors/google_play_sign_in_errors.dart';
import 'package:infinitywords/modules/auth/domain/usecases/google_play_sign_in_usecase.dart';
import 'package:infinitywords/modules/auth/presenter/blocs/events/sign_in_event.dart';
import 'package:infinitywords/modules/auth/presenter/blocs/states/sign_in_state.dart';
import 'package:infinitywords/shared/widgets/message_widget.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final GooglePlaySignInUsecase _usecase;
  SignInBloc(this._usecase) : super(InitialSignInState()) {
    on<GooglePlaySignInEvent>(_handleGooglePlaySignInEvent);
  }

  Future<void> _handleGooglePlaySignInEvent(
    GooglePlaySignInEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(LoadingSignInState());

    final result = await _usecase();

    result.when(
      (success) => emit(SuccessSignInState()),
      (error) => emit(ErrorSignInState.googlePlayError(error)),
    );
  }

  void signIn() {
    add(GooglePlaySignInEvent());
  }

  void handleListener(BuildContext ctx, SignInState state) {
    if (state is InitialSignInState) return;

    if (state is LoadingSignInState) return;

    if (state is ErrorSignInState) {
      showErrorMessage(state.googlePlayError!, ctx);
    }

    if (state is SuccessSignInState) {}
  }

  Future<void> showErrorMessage(
    GooglePlaySignInError error,
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
