import 'dart:math';
import 'package:flutter/material.dart';
import 'package:infinitywords/modules/home/domain/entities/game_entity.dart';

class WordBoardComponent extends CustomPainter {
  WordBoardComponent(this.context, {required this.game});
  final BuildContext context;
  final GameEntity game;

  @override
  void paint(Canvas canvas, Size size) {
    const allChars = 'abcdefghijklmnopqrstuvwxyz';

    final maxWidth = size.width - (size.width % 20);
    final maxHeight = size.height - (size.height % 20);

    final random = Random();

    final textStyle = Theme.of(context).textTheme.bodyMedium;
    final boardPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeWidth = 2;
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final List<Offset> positions = [];

    /// Set all avaliable positions
    for (double y = 0; y < maxHeight; y += 20) {
      for (double x = 10; x < maxWidth; x += 20) {
        positions.add(Offset(x, y));
      }
    }

    /// Draw all topic words
    for (String word in game.words) {
      final position = positions[random.nextInt(positions.length - 60)];
      final positionIndex = positions.indexOf(position);
      for (String letter in word.split('')) {
        textPainter.text = TextSpan(
          text: letter.toLowerCase(),
          style: textStyle,
        );
        textPainter.layout();
        textPainter.paint(canvas, positions[positionIndex]);
        positions.removeAt(positionIndex);
      }
    }

    /// Fill the board
    for (Offset position in positions) {
      textPainter.text = TextSpan(
        text: allChars[random.nextInt(allChars.length)],
        style: textStyle,
      );
      textPainter.layout();
      textPainter.paint(canvas, position);
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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
