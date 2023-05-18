import 'package:flutter/material.dart';
import 'package:infinitywords/modules/home/presenter/components/dificult_game_button_component.dart';

class CreateGameScreen extends StatefulWidget {
  const CreateGameScreen({super.key});

  @override
  State<CreateGameScreen> createState() => _CreateGameScreenState();
}

class _CreateGameScreenState extends State<CreateGameScreen> {
  GlobalKey selectedKey = GlobalKey();

  void changeSelectedButton(GlobalKey key) {
    setState(() {
      selectedKey = key;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 90,
          bottom: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Criar\nnovo jogo',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 40),
            Text(
              'Assunto:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            Form(
              // key: _bloc.formKey,
              child: TextFormField(
                // controller: _bloc.inputController,
                // validator: _bloc.inputValidator,
                cursorColor: Colors.white,
                style: Theme.of(context).textTheme.bodySmall,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  labelText: 'Futebol, filmes, séries...',
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white.withOpacity(0.5)),
                ),
              ),
            ),
            const SizedBox(height: 60),
            Text(
              'Dificuldade:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DificultGameButtonComponent(
                  dificult: 'Fácil',
                  onPressed: changeSelectedButton,
                  selectedKey: selectedKey,
                ),
                DificultGameButtonComponent(
                  dificult: 'Normal',
                  onPressed: changeSelectedButton,
                  selectedKey: selectedKey,
                ),
                DificultGameButtonComponent(
                  dificult: 'Difícil',
                  onPressed: changeSelectedButton,
                  selectedKey: selectedKey,
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: OutlinedButton(
                onPressed: () {},
                child: Text(
                  'Criar',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
            Center(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
                      side: const MaterialStatePropertyAll(BorderSide.none),
                    ),
                child: Text(
                  'Voltar',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}
