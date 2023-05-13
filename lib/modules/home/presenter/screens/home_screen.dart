import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              style: Theme.of(context).textTheme.bodySmall,
              decoration: InputDecoration(
                labelText: 'Futebol, filmes, séries...',
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white.withOpacity(0.5)),
              ),
            ),
            const SizedBox(height: 100),
            // SegmentedButton(segments: segments, selected: selected)
          ],
        ),
      ),
    );
  }
}
