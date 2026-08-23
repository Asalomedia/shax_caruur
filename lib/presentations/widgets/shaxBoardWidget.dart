import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shax_caruur/game/positions.dart';

class Shaxboardwidget extends StatelessWidget {
  final Size size;
  const new({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    log(
      "width:${size.width},height:${size.height}",
    ); // widht and height must be same for square
    final double margin = 15.0;

    return CustomPaint(
      painter: ShaxPainter(),
      size: Size(size.width - 2 * margin, size.height - 2 * margin),
    );
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
      Position(
        coordinate: Offset(0, 0),
        tpe: PositionsType.topLeft,
        positionId: 1,
      ),
      Position(
        coordinate: Offset(center.dx, 0),
        tpe: PositionsType.topCenter,
        positionId: 2,
      ),
      Position(
        coordinate: Offset(size.width, 0),
        tpe: PositionsType.topRight,
        positionId: 3,
      ),

      Position(
        coordinate: Offset(0, center.dy),
        tpe: PositionsType.centerLeft,
        positionId: 4,
      ),
      Position(coordinate: center, tpe: PositionsType.center, positionId: 5),
      Position(
        coordinate: Offset(size.width, center.dy),
        tpe: PositionsType.centerRight,
        positionId: 6,
      ),

      Position(
        coordinate: Offset(0, size.height),
        tpe: PositionsType.bottomLeft,
        positionId: 7,
      ),
      Position(
        coordinate: Offset(center.dx, size.height),
        tpe: PositionsType.bottomCenter,
        positionId: 8,
      ),
      Position(
        coordinate: Offset(size.width, size.height),
        tpe: PositionsType.bottomRight,
        positionId: 9,
      ),
    ];
    for (Position position in actualPositions) {
      canvas.drawCircle(position.coordinate!, radius, circlepaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
