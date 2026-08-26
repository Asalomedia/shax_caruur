import 'dart:developer';
import 'dart:ui';

import 'package:shax_caruur/game/game_controller_intf.dart';
import 'package:shax_caruur/models/player.dart';
import 'package:shax_caruur/models/position.dart';

class GameController implements IController {
  @override
  Set<Position>? canHeWin({
    required Player currentPlayer,
    required Set<Position> allpositions,
    required Set<Piece> allpieces,
  }) {
    final Set<Piece> piecesPlayed = _piecesPlayed(allpieces);
    if (piecesPlayed.length >= 5) {
      List<int> firstRow = [1, 2, 3];
      List<int> secondRow = [4, 5, 6];
      List<int> thirdRow = [7, 8, 9];
      List<int> firstColunn = [1, 4, 7];
      List<int> secondColumn = [2, 5, 8];
      List<int> thirdColumn = [3, 6, 9];
      List<int> primaryDiagnal = [1, 5, 9];
      List<int> secondaryDiagnal = [3, 5, 7];
      List<List<int>> winableLines = [
        firstRow,
        secondRow,
        thirdRow,
        firstColunn,
        secondColumn,
        thirdColumn,
        primaryDiagnal,
        secondaryDiagnal,
      ];
      final Set<Piece> currentPlayersplayedPieces = piecesPlayed
          .where((p) => p.player == currentPlayer)
          .toSet();
      for (List<int> winableLine in winableLines) {
        final bool heWonWithThisLine = currentPlayersplayedPieces.every(
          (p) => winableLine.contains(p.positionId),
        );
        if (heWonWithThisLine) {
          log(winableLine.toString());
          return allpositions
              .where((p) => winableLine.contains(p.positionId))
              .toSet();
        }
      }
    } else {
      return null;
    }
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
      if (distance <= pieceRadius * 1.5) {
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
      if (distance <= (pieceRadius * 2 + posRadius * 2)) {
        final bool occupied = _thisPositionIsOccupied(
          position.positionId,
          pieces,
        );
        if (!occupied) {
          if (piece.positionId == null) {
            return piece.copyWith(
              newcoordinate: position.coordinate,
              posId: position.positionId,
            );
          } else {
            //this position can go only legal ones
            if (isLegal(piece.positionId!, actualpositions, position)) {
              return piece.copyWith(
                newcoordinate: position.coordinate,
                posId: position.positionId,
              );
            }
          }
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

  Set<Piece> _piecesPlayed(Set<Piece> pieces) {
    return pieces.where((e) => e.positionId != null).toSet();
  }

  bool isLegal(
    int positionId,
    Set<Position> actualpositions,
    Position nwPosition,
  ) {
    final Position whereItISAt = actualpositions.firstWhere(
      (p) => p.positionId == positionId,
    );
    return whereItISAt.legalMovesFromHere.contains(nwPosition.positionId);
  }
}
