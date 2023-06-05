import 'dart:math';
import 'package:flutter/material.dart';
import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';
import 'package:infinitywords/modules/home/domain/enums/dificult_enum.dart';

class WordBoardComponent extends CustomPainter {
  WordBoardComponent(this.context, {required this.game});
  final BuildContext context;
  final GameEntity game;
  @override
  void paint(Canvas canvas, Size size) {
    final wordsShuffle = game.dificult.wordsShuffle;
    const allChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    final maxWidth = size.width - (size.width % 20);
    final maxHeight = size.height - (size.height % 20);

    final random = Random();

    final textStyle = Theme.of(context).textTheme.bodyMedium;
    final boardPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeWidth = 2;

    List<Offset> charPositions = [];
    TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (double y = 0; y < maxHeight; y += 20) {
      for (double x = 0; x < maxWidth; x += 20) {
        charPositions.add(Offset(x, y));
      }
    }

    /// Word board container
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: maxWidth + 10,
          height: maxHeight + 10,
        ),
        const Radius.circular(8),
      ),
      boardPaint,
    );

    int getInitialIndex(int length, bool isVertical) {
      final position = charPositions[random.nextInt(charPositions.length)];
      if (((isVertical ? position.dy : position.dx) + (20 * length)) >
          maxWidth) {
        getInitialIndex(length, isVertical);
      }
      Offset initialPosition = position;
      int initialIndex = charPositions.indexOf(initialPosition);
      return initialIndex;
    }

    for (String word in game.words) {
      final shuffle = wordsShuffle[random.nextInt(wordsShuffle.length)];
      List<Offset> selectedPositions = [];

      switch (shuffle) {
        case WordShuffle.leftRight:
          final length = word.length;
          final initialIndex = getInitialIndex(length, false);
          for (int index = 0; index < length; index++) {
            final position = charPositions[initialIndex];
            selectedPositions.add(position);
            charPositions.remove(position);
          }
          break;
        case WordShuffle.topBottom:
          final length = word.length;
          final initialIndex = getInitialIndex(length, true);

          for (int index = 0; index < length; index++) {
            final position = charPositions[initialIndex + index];
            selectedPositions.add(position);
            charPositions.remove(position);
          }
          break;
        case WordShuffle.crossToRight:
          final length = word.length;
          final initialIndex = getInitialIndex(length, false);
          for (int index = 0; index < length; index++) {
            final position = charPositions[initialIndex + index];
            selectedPositions.add(position);
            charPositions.remove(position);
          }
          break;

        case WordShuffle.crossToLeft:
          final length = word.length;
          final initialIndex = getInitialIndex(length, false);
          for (int index = 0; index < length; index++) {
            final position = charPositions[initialIndex + index];
            selectedPositions.add(position);
            charPositions.remove(position);
          }
          break;
      }

      for (int w = 0; w <= word.length; w++) {
        TextSpan textSpan = TextSpan(
          text: word[w],
          style: textStyle,
        );
        textPainter.text = textSpan;
        textPainter.layout(
          maxWidth: 20,
          minWidth: 20,
        );
        textPainter.paint(canvas, selectedPositions[w]);
      }
    }

    for (var position in charPositions) {
      TextSpan textSpan = TextSpan(
        text: allChars[Random().nextInt(allChars.length)],
        style: textStyle,
      );
      textPainter.text = textSpan;
      textPainter.layout(
        maxWidth: 20,
        minWidth: 20,
      );
      textPainter.paint(canvas, position);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
