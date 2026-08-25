import 'dart:ui';

import 'package:shax_caruur/game/game_controller_intf.dart';
import 'package:shax_caruur/models/player.dart';
import 'package:shax_caruur/models/position.dart';

class GameController implements IController {
  @override
  bool canHeWin({
    required Player currentPlayer,
    required List<Position> occupiedPositions,
  }) {
    // TODO: implement canHeWin
    throw UnimplementedError();
  }

  @override
  Piece? hitPiece({
    required Offset whereYouTapped,
    required double pieceRadius,
    required Set<Piece> availablePieces,
    required Player currentPlayer,
  }) {
    final Set<Piece> pocket = availablePieces
        .where((e) => e.player == currentPlayer)
        .toSet();
    for (Piece piece in pocket) {
      final Offset diff = whereYouTapped - piece.coordinate;
      final distance = diff.distance;
      if (distance <= pieceRadius) {
        if (piece.positionId == null) {
          //if piece is not played yet, do it
          return piece;
        } else {
          //if piece was played before
          final bool isAllPutOnBoard = _allpiecesPut(
            availablePieces,
          ); //check if all others are played as well
          if (isAllPutOnBoard) {
            //if all other were played on, then move it on board
            return piece;
          } else {
            // else you should select another piece which was not played
            return null;
          }
        }
      }
    }
    return null;
  }

  @override
  Piece? putPieceOnPosition({
    required Piece piece,
    required Offset whereDragEnds,
    required double pieceRadius,
    required double posRadius,
    required Set<Position> actualpositions,
    required Set<Piece> pieces,
  }) {
    for (Position position in actualpositions) {
      final Offset diff = whereDragEnds - position.coordinate;
      final double distance = diff.distance;
      if (distance <= (pieceRadius + posRadius * 2)) {
        final bool occupied = _thisPositionIsOccupied(
          position.positionId,
          pieces,
        );
        if (!occupied) {
          return piece.copyWith(
            newcoordinate: position.coordinate,
            posId: position.positionId,
          );
        }
      }
    }
    return null;
  }

  bool _thisPositionIsOccupied(int posId, Set<Piece> pieces) {
    for (Piece p in pieces) {
      if (p.positionId != null) {
        if (p.positionId == posId) {
          return true;
        }
      }
    }
    return false;
  }

  bool _allpiecesPut(Set<Piece> pieces) {
    return pieces.every((piece) => piece.positionId != null);
  }

  bool _fourPiecesPlayed(Set<Piece> pieces) {
    final int howmanyPlayed = pieces.where((e) => e.positionId != null).length;
    return howmanyPlayed > 4;
  }
}
