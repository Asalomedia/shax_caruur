import 'dart:ui';

import 'package:shax_caruur/models/player.dart' show Player;
import 'package:shax_caruur/models/position.dart';

abstract interface class IController {
  void setSize(Size totalSize);
  void fillPositionsAndPieces();
  Set<Position> get getPositions;
  Set<Piece> get getPieces;
  double get fromTop;
  double get fromleft;
  Size get boardSize;
  set setTheOneWeFound(Piece piece);
  Piece? get getTheOneWefound;
  double get getPieceRadius;
  double get getPositionRadius;
  void hitPiece({
    required Offset whereYouTapped,
    required Player currentPlayer,
  });
  bool putPieceOnPosition({required Offset whereDragEnds});
  Set<Position>? canHeWin({required Player currentPlayer});
  void restart();
  void dispose();
}
