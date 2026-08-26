import 'package:flutter/material.dart'
    show
        Canvas,
        Color,
        Colors,
        Offset,
        Paint,
        PaintingStyle,
        Rect,
        Size,
        TextSpan,
        TextPainter,
        TextDirection,
        TextStyle;
import 'package:flutter/painting.dart';
import 'package:shax_caruur/models/player.dart' show Player;
import 'package:shax_caruur/models/position.dart' show Position, Piece;
import 'package:shax_caruur/state_management/home_cubit.dart';
import 'package:shax_caruur/state_management/home_states.dart';

void drawShax(
  Canvas canvas,
  Size size,
  double fromTop,
  double fromLeft, {
  required HomeCubit homeCubit,
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
    Position(
      coordinate: Offset(0 + fromLeft, 0 + fromTop),
      positionId: 1,
      legalMovesFromHere: [2, 5, 4],
    ),
    Position(
      coordinate: Offset(center.dx + fromLeft, 0 + fromTop),
      positionId: 2,
      legalMovesFromHere: [1, 5, 3],
    ),
    Position(
      coordinate: Offset(size.width + fromLeft, 0 + fromTop),
      positionId: 3,
      legalMovesFromHere: [2, 5, 6],
    ),

    Position(
      coordinate: Offset(0 + fromLeft, center.dy + fromTop),
      positionId: 4,
      legalMovesFromHere: [1, 5, 7],
    ),
    Position(
      coordinate: Offset(center.dx + fromLeft, center.dy + fromTop),
      positionId: 5,
      legalMovesFromHere: [1, 2, 3, 4, 6, 7, 8, 9],
    ),
    Position(
      coordinate: Offset(size.width + fromLeft, center.dy + fromTop),
      positionId: 6,
      legalMovesFromHere: [3, 5, 9],
    ),
    Position(
      coordinate: Offset(0 + fromLeft, size.height + fromTop),
      positionId: 7,
      legalMovesFromHere: [8, 5, 4],
    ),
    Position(
      coordinate: Offset(center.dx + fromLeft, size.height + fromTop),
      positionId: 8,
      legalMovesFromHere: [7, 5, 9],
    ),
    Position(
      coordinate: Offset(size.width + fromLeft, size.height + fromTop),
      positionId: 9,
      legalMovesFromHere: [8, 5, 6],
    ),
  ];
  for (Position position in actualPositions) {
    canvas.drawCircle(position.coordinate, radius, circlepaint);
  }
  homeCubit.registerImportantPositions(actualPositions);
}

void drawPockets(
  Canvas canvas,
  Size size, {
  required HomeCubit homeCubit,
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
    homeCubit.registerPieces(pieces);
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
  } else {
    state as EndgameState;
    for (Piece p in state.pieces) {
      canvas.drawCircle(
        p.coordinate,
        radius,
        p.player == Player.rock ? rockPaint : coalPaint,
      );
    }
    final Set<Position> positionHeWon = state.positionHeWon;
    final Offset first = positionHeWon.first.coordinate;
    final Offset middle = positionHeWon.elementAt(1).coordinate;
    final Offset last = positionHeWon.last.coordinate;
    final Paint winingLinePaint = Paint();
    winingLinePaint.strokeWidth = size.width / 40;
    winingLinePaint.color = currentPlayer == Player.rock
        ? Colors.red
        : Colors.yellow;
    canvas.drawLine(first, middle, winingLinePaint);
    canvas.drawLine(middle, last, winingLinePaint);
  }

  _playerShower(canvas, state, radius, size);
}

void _playerShower(Canvas canvas, HomeStates state, double radius, Size size) {
  _paintPlayer(
    canvas,
    size,
    state,
    Offset(radius, size.height / 10),
    Player.rock,
  );
  _paintPlayer(
    canvas,
    size,
    state,
    Offset(radius, size.height - size.height / 10),
    Player.coal,
  );
}

void _paintPlayer(
  Canvas canvas,
  Size size,
  HomeStates state,
  Offset pos,
  Player player,
) {
  // 2. Wrap content in a TextSpan
  final textSpan = TextSpan(
    text: player.toString(),
    style: TextStyle(
      fontWeight: FontWeight(600),
      fontSize: size.width / 20,
      color: player == Player.rock ? Colors.red : Colors.black,
    ),
  );

  // 3. Initialize TextPainter
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr, // Mandatory layout configuration
  );

  // 4. Compute the spatial dimensions of the text
  textPainter.layout(
    minWidth: 0,
    maxWidth: size.width, // Wrap text if it exceeds width boundaries
  );

  // 5. Draw the text to the canvas at a specific coordinate
  // This example places the top-left corner of the text at coordinate (50, 100)
  textPainter.paint(canvas, pos);
}
