import 'package:flutter/material.dart'
    show
        BuildContext,
        Canvas,
        Color,
        Colors,
        Offset,
        Paint,
        PaintingStyle,
        Rect,
        Size;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shax_caruur/models/player.dart' show Player;
import 'package:shax_caruur/models/position.dart' show Position, Piece;
import 'package:shax_caruur/state_management/home_cubit.dart';
import 'package:shax_caruur/state_management/home_states.dart';

void drawShax(
  Canvas canvas,
  Size size,
  double fromTop,
  double fromLeft, {
  required BuildContext context,
  required HomeStates state,
  required double radius,
}) {
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
  List<Position> actualPositions = [
    Position(coordinate: Offset(0 + fromLeft, 0 + fromTop), positionId: 1),
    Position(
      coordinate: Offset(center.dx + fromLeft, 0 + fromTop),
      positionId: 2,
    ),
    Position(
      coordinate: Offset(size.width + fromLeft, 0 + fromTop),
      positionId: 3,
    ),

    Position(
      coordinate: Offset(0 + fromLeft, center.dy + fromTop),
      positionId: 4,
    ),
    Position(
      coordinate: Offset(center.dx + fromLeft, center.dy + fromTop),
      positionId: 5,
    ),
    Position(
      coordinate: Offset(size.width + fromLeft, center.dy + fromTop),
      positionId: 6,
    ),
    Position(
      coordinate: Offset(0 + fromLeft, size.height + fromTop),
      positionId: 7,
    ),
    Position(
      coordinate: Offset(center.dx + fromLeft, size.height + fromTop),
      positionId: 8,
    ),
    Position(
      coordinate: Offset(size.width + fromLeft, size.height + fromTop),
      positionId: 9,
    ),
  ];
  for (Position position in actualPositions) {
    canvas.drawCircle(position.coordinate, radius, circlepaint);
  }
  BlocProvider.of<HomeCubit>(context)
      .registerImportantPositions(actualPositions);
}

void drawPockets(
  Canvas canvas,
  Size size, {
  required BuildContext context,
  required HomeStates state,
  required double radius,
}) {
  final Paint rockPaint = Paint();
  rockPaint.color = const Color.fromARGB(208, 168, 144, 117);
  final Paint coalPaint = Paint();
  coalPaint.color = const Color.fromARGB(255, 15, 12, 19);
  List<Piece> pieces = [
    Piece(
      id: 100,
      coordinate: Offset(size.width / 2 - 2 * radius, size.height / 10),
      player: Player.rock,
    ),
    Piece(
      id: 101,
      coordinate: Offset(size.width / 2, size.height / 10),
      player: Player.rock,
    ),
    Piece(
      id: 102,
      coordinate: Offset(size.width / 2 + 2 * radius, size.height / 10),
      player: Player.rock,
    ), // this three for rock
    Piece(
      id: 103,
      coordinate: Offset(
        size.width / 2 - 2 * radius,
        size.height - size.height / 10,
      ),
      player: Player.coal,
    ),
    Piece(
      id: 104,
      coordinate: Offset(size.width / 2, size.height - size.height / 10),
      player: Player.coal,
    ),
    Piece(
      id: 105,
      coordinate: Offset(
        size.width / 2 + 2 * radius,
        size.height - size.height / 10,
      ),
      player: Player.coal,
    ), // this three for rock
  ];
  if (state.runtimeType == InitialState) {
    for (Piece p in pieces) {
      canvas.drawCircle(
        p.coordinate,
        radius,
        p.player == Player.rock ? rockPaint : coalPaint,
      );
    }
    BlocProvider.of<HomeCubit>(context).registerPieces(pieces);
  } else if (state.runtimeType == DragingState) {
    state as DragingState;
    for (Piece p in state.pieces) {
      canvas.drawCircle(
        p.coordinate,
        radius,
        p.player == Player.rock ? rockPaint : coalPaint,
      );
    }
  } else if (state.runtimeType == DragEndState) {
    state as DragEndState;
    for (Piece p in state.pieces) {
      canvas.drawCircle(
        p.coordinate,
        radius,
        p.player == Player.rock ? rockPaint : coalPaint,
      );
    }
  }
}
