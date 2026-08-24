import 'dart:developer';
import 'dart:math' as m;

import 'package:flutter/material.dart';
import 'package:shax_caruur/models/position.dart' show Position;

class Shaxboardwidget extends StatelessWidget {
  final BoxConstraints constraint;
  const Shaxboardwidget({super.key, required this.constraint});

  @override
  Widget build(BuildContext context) {
    final width = constraint.maxWidth;
    final height = constraint.maxHeight;
    final boardsize = m.min(width, height);
    final Size size = Size.square(boardsize); //size of board
    log(
      "width:${size.width},height:${size.height}",
    ); // widht and height must be same for square
    final double margin = 15.0;
    final Size cSize = Size(size.width - 2 * margin, size.height - 2 * margin);
    return CustomPaint(painter: ShaxPainter(), size: cSize);
  }
}

class ShaxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = size.width / 50;
    //DRAW SQUARE
    final paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.color = Colors.white;
    paint.strokeWidth = strokeWidth;
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    canvas.drawRect(rect, paint);
    //DRAW CROSS ON SQUARE

    final Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawLine(
      Offset(center.dx, 0),
      Offset(center.dx, size.height),
      paint,
    ); //vertical line
    canvas.drawLine(
      Offset(0, center.dy),
      Offset(size.width, center.dy),
      paint,
    ); //horizontal line

    //DRAW DIAGNAL CROSS ON SQUARE
    canvas.drawLine(
      Offset(0, 0),
      Offset(size.width, size.height),
      paint,
    ); //leading diagnal
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(0, size.height),
      paint,
    ); //secondary diagnal

    //DRAW HABITABLE POINTS (SHOW JOINTS)
    final double radius = size.width / 30;
    final circlepaint = Paint();
    circlepaint.color = const Color.fromARGB(173, 255, 255, 255);
    circlepaint.style = PaintingStyle.fill;
    List<Position> actualPositions = [
      Position(coordinate: Offset(0, 0), positionId: 1),
      Position(coordinate: Offset(center.dx, 0), positionId: 2),
      Position(coordinate: Offset(size.width, 0), positionId: 3),

      Position(coordinate: Offset(0, center.dy), positionId: 4),
      Position(coordinate: center, positionId: 5),
      Position(coordinate: Offset(size.width, center.dy), positionId: 6),

      Position(coordinate: Offset(0, size.height), positionId: 7),
      Position(coordinate: Offset(center.dx, size.height), positionId: 8),
      Position(coordinate: Offset(size.width, size.height), positionId: 9),
    ];
    for (Position position in actualPositions) {
      canvas.drawCircle(position.coordinate, radius, circlepaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
