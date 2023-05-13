import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 90,
          bottom: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Boa\nTarde',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 40),
            Text(
              'Sobre o que você quer\njogar hoje?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),
            TextField(
              cursorColor: Colors.white,
              style: Theme.of(context).textTheme.bodySmall,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.white,
                ),
                labelText: 'Futebol, filmes, séries...',
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white.withOpacity(0.5)),
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
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: TabBarView(controller: _tabController, children: [
                  ListView.builder(
                    itemCount: 10,
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
                            'Harry Potter',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          subtitle: Text(
                            'Dificuldade: Média',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  ListView.builder(
                    itemCount: 10,
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
                            'Avatar',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          subtitle: Text(
                            'Dificuldade: Fácil',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
