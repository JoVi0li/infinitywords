import 'package:flutter/material.dart';

class WordListComponent extends StatefulWidget {
  const WordListComponent({
    super.key,
    required this.words,
  });
  final List<String> words;

  @override
  State<WordListComponent> createState() => _WordListComponentState();
}

class _WordListComponentState extends State<WordListComponent> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: widget.words
          .map((e) => Chip(
                backgroundColor: const Color(0xFF313040),
                label: Text(
                  e,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ))
          .toList(),
    );
  }
}
