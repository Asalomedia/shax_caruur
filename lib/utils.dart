import 'package:flutter/material.dart'
    show Canvas, Color, Colors, Offset, Paint, PaintingStyle, Rect, Size;

import 'package:shax_caruur/models/player.dart' show Player;
import 'package:shax_caruur/models/position.dart' show Position, Piece;
import 'package:shax_caruur/state_management/home_cubit.dart';
import 'package:shax_caruur/state_management/home_states.dart';

void drawShax(
  Canvas canvas, {
  required HomeCubit homeCubit,
  required HomeStates state,
}) {
  final Size size = homeCubit.gameController.boardSize;
  final double fromLeft = homeCubit.gameController.fromleft;
  final double fromTop = homeCubit.gameController.fromTop;
  final double strokeWidth = size.width / 50;
  //DRAW SQUARE
  final paint = Paint();
  paint.style = PaintingStyle.stroke;
  paint.color = Colors.white;
  paint.strokeWidth = strokeWidth;
  final rect = Rect.fromLTRB(
    0 + fromLeft,
    0 + fromTop,
    size.width + fromLeft,
    size.height + fromTop,
  );
  canvas.drawRect(rect, paint);
  //DRAW CROSS ON SQUARE
  final Offset center = Offset(size.width / 2, size.height / 2);
  canvas.drawLine(
    Offset(center.dx + fromLeft, 0 + fromTop),
    Offset(center.dx + fromLeft, size.height + fromTop),
    paint,
  ); //vertical line
  canvas.drawLine(
    Offset(0 + fromLeft, center.dy + fromTop),
    Offset(size.width + fromLeft, center.dy + fromTop),
    paint,
  ); //horizontal line

  //DRAW DIAGNAL CROSS ON SQUARE
  canvas.drawLine(
    Offset(0 + fromLeft, 0 + fromTop),
    Offset(size.width + fromLeft, size.height + fromTop),
    paint,
  ); //leading diagnal
  canvas.drawLine(
    Offset(size.width + fromLeft, 0 + fromTop),
    Offset(0 + fromLeft, size.height + fromTop),
    paint,
  ); //secondary diagnal

  //DRAW HABITABLE POINTS (SHOW JOINTS)
  final circlepaint = Paint();
  circlepaint.color = const Color.fromARGB(173, 255, 255, 255);
  circlepaint.style = PaintingStyle.fill;

  for (Position position in homeCubit.gameController.getPositions) {
    canvas.drawCircle(position.coordinate, position.radius, circlepaint);
  }
}

void drawPockets(
  Canvas canvas,
  Size size, {
  required HomeCubit homeCubit,
  required HomeStates state,
}) {
  final Paint redPaint = Paint();
  redPaint.color = Colors.red;
  final Paint greenPaint = Paint();
  greenPaint.color = Colors.green;
  if (state.runtimeType == InitialState) {
    for (Piece p in homeCubit.gameController.getPieces) {
      canvas.drawCircle(
        p.coordinate,
        p.pieceRadius,
        p.player == Player.red ? redPaint : greenPaint,
      );
    }
  } else if (state.runtimeType == DragingState) {
    state as DragingState;
    for (Piece p in state.pieces) {
      canvas.drawCircle(
        p.coordinate,
        p.pieceRadius,
        p.player == Player.red ? redPaint : greenPaint,
      );
    }
  } else if (state.runtimeType == DragEndState) {
    state as DragEndState;
    for (Piece p in state.pieces) {
      canvas.drawCircle(
        p.coordinate,
        p.pieceRadius,
        p.player == Player.red ? redPaint : greenPaint,
      );
    }
  } else {
    state as EndgameState;
    for (Piece p in state.pieces) {
      canvas.drawCircle(
        p.coordinate,
        p.pieceRadius,
        p.player == Player.red ? redPaint : greenPaint,
      );
    }
    //Wining drawer
    final Set<Position> positionHeWon = state.positionHeWon;
    final Offset first = positionHeWon.first.coordinate;
    final Offset middle = positionHeWon.elementAt(1).coordinate;
    final Offset last = positionHeWon.last.coordinate;
    final Paint winingLinePaint = Paint();
    winingLinePaint.strokeWidth = size.width / 40;
    winingLinePaint.color = currentPlayer == Player.red
        ? Colors.red
        : Colors.green;
    canvas.drawLine(first, middle, winingLinePaint);
    canvas.drawLine(middle, last, winingLinePaint);
  }
}
