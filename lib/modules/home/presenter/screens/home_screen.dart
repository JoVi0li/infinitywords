import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinitywords/modules/home/domain/entities/historic_game_entity.dart';
import 'package:infinitywords/modules/home/presenter/blocs/blocs/home_bloc.dart';
import 'package:infinitywords/modules/home/presenter/blocs/events/home/start_create_game_event.dart';
import 'package:infinitywords/modules/home/presenter/blocs/events/home/get_favorite_games_event.dart';
import 'package:infinitywords/modules/home/presenter/blocs/events/home/get_recent_games_event.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/home/get_favorite_games_state.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/home/get_recent_games_state.dart';
import 'package:infinitywords/modules/home/presenter/blocs/states/home/home_state.dart';
import 'package:infinitywords/modules/home/presenter/components/game_list_component.dart';
import 'package:infinitywords/shared/widgets/message_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final getIt = GetIt.I;
  late final TabController _tabController;
  late final HomeBloc _bloc;
  List<HistoricGameEntity> favoriteGames = [];
  List<HistoricGameEntity> recentGames = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _bloc = getIt<HomeBloc>();
    addGetFavoriteGamesEvent();
    addGetRecentGamesEvent();
  }

  @override
  void dispose() {
    _tabController.dispose();
    getIt.resetLazySingleton<HomeBloc>();
    super.dispose();
  }

  void addCreateGameEvent({
    required String input,
    required BuildContext context,
  }) {
    _bloc.add(StartCreateGameEvent(input: input, context: context));
  }

  void addGetFavoriteGamesEvent() {
    _bloc.add(GetFavoriteGamesEvent());
  }

  void addGetRecentGamesEvent() {
    _bloc.add(GetRecentGamesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
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
                _bloc.welcomeMessage,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 40),
              Text(
                'Sobre o que você quer\njogar hoje?',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              Form(
                key: _bloc.formKey,
                child: TextFormField(
                  controller: _bloc.inputController,
                  validator: _bloc.inputValidator,
                  focusNode: _bloc.inputFocus,
                  cursorColor: Colors.white,
                  style: Theme.of(context).textTheme.bodySmall,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () => addCreateGameEvent(
                        input: _bloc.inputController.value.text,
                        context: context,
                      ),
                    ),
                    labelText: 'Futebol, filmes, séries...',
                    labelStyle: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white.withOpacity(0.5)),
                  ),
                ),
              ),
              const SizedBox(height: 100),
              TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFF313040),
                splashBorderRadius: const BorderRadius.all(Radius.circular(8)),
                tabs: [
                  Tab(
                    child: Text(
                      'Recentes',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Favoritos',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              BlocListener<HomeBloc, HomeState>(
                bloc: _bloc,
                listener: (context, state) {
                  if (state is InitialHomeState) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  if (state is SuccessGetFavoriteGamesState) {
                    setState(() {
                      isLoading = false;
                      favoriteGames = state.games.historicGames;
                    });
                  }

                  if (state is SuccessGetRecentGamesState) {
                    setState(() {
                      isLoading = false;
                      recentGames = state.games.historicGames;
                    });
                  }

                  if (state is ErrorGetFavoriteGamesState) {
                    setState(() {
                      isLoading = false;
                    });
                    showDialog<void>(
                      context: context,
                      builder: (ctx) => MessageWidget(
                        title: state.error.code,
                        message: state.error.message,
                      ),
                    );
                  }
                  if (state is ErrorGetRecentGamesState) {
                    setState(() {
                      isLoading = false;
                    });
                    showDialog<void>(
                      context: context,
                      builder: (ctx) => MessageWidget(
                        title: state.error.code,
                        message: state.error.message,
                      ),
                    );
                  }

                  if (state is LoadingGetFavoriteGamesState ||
                      state is LoadingGetRecentGamesState) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                },
                child: Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        GameListComponent(
                          games: recentGames,
                          isLoading: isLoading,
                        ),
                        GameListComponent(
                          games: favoriteGames,
                          isLoading: isLoading,
                        ),
                      ],
                    ),
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
