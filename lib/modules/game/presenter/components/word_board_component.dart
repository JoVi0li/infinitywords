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

    List<Map<String, dynamic>> positions = [];
    TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (double y = 0; y < maxHeight; y += 20) {
      for (double x = 0; x < maxWidth; x += 20) {
        positions.add({
          'position': Offset(x, y),
          'avaliable': true,
        });
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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
