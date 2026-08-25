import 'dart:ui';

import 'package:shax_caruur/models/player.dart' show Player;
import 'package:shax_caruur/models/position.dart';

abstract interface class IController {
  Piece? hitPiece({
    required Offset whereYouTapped,
    required double pieceRadius,
    required Set<Piece> availablePieces,
    required Player currentPlayer,
  });
  Piece? putPieceOnPosition({
    required Piece piece,
    required Offset whereDragEnds,
    required double pieceRadius,
    required double posRadius,
    required Set<Position> actualpositions,
    required Set<Piece> pieces,
  });
  bool canHeWin({
    required Player currentPlayer,
    required List<Position> occupiedPositions,
  });
}
