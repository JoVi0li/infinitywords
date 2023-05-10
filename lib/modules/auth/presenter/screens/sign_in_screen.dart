import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinitywords/modules/auth/presenter/blocs/bloc/sign_in_bloc.dart';
import 'package:infinitywords/modules/auth/presenter/blocs/states/sign_in_state.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _getIt = GetIt.I;
  late final SignInBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = _getIt<SignInBloc>();
  }

  @override
  void dispose() {
    _getIt.resetLazySingleton<SignInBloc>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignInBloc, SignInState>(
        bloc: _bloc,
        listener: _bloc.handleListener,
        builder: (context, state) => Padding(
          padding: const EdgeInsets.only(
            top: 130,
            bottom: 90,
            left: 32,
            right: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Palavras\nInfinitas',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Um jogo de caça-\npalavras sobre o que\nvocê quiser.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Spacer(),
              Center(
                child: OutlinedButton(
                  onPressed: _bloc.signIn,
                  child: Text(
                    'Entrar',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
