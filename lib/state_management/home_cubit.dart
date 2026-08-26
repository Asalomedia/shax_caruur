import 'package:flutter/material.dart' show Offset;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shax_caruur/game/game_controller.dart';
import 'package:shax_caruur/game/game_controller_intf.dart';
import 'package:shax_caruur/models/player.dart';
import 'package:shax_caruur/models/position.dart';
import 'package:shax_caruur/models/score.dart';

import 'package:shax_caruur/state_management/home_states.dart'
    show DragEndState, DragingState, EndgameState, HomeStates, InitialState;

Player currentPlayer = Player.rock;

class HomeCubit extends Cubit<HomeStates> {
  final Set<Position> positions = {};
  final Set<Piece> pieces = {};
  Piece? theOneWefound;
  final IController gameController = GameController();
  final Score score = Score(score: {Player.rock: 0, Player.coal: 0});
  HomeCubit() : super(InitialState(currentPlayer: currentPlayer));

  void registerImportantPositions(List<Position> actualpos) {
    positions.addAll(actualpos);
  }

  void registerPieces(List<Piece> orginalpiecel) {
    pieces.addAll(orginalpiecel);
  }

  Piece? findPieceIHit(
    Offset whereIHit,
    double pieceRadius,
    Player currentPlayer,
  ) {
    final Piece? piece = gameController.hitPiece(
      whereYouTapped: whereIHit,
      pieceRadius: pieceRadius,
      availablePieces: pieces,
      currentPlayer: currentPlayer,
    );
    if (piece != null) {
      theOneWefound = piece;
    }
    return piece;
  }

  void updatePieceLocation(Offset newLocation) {
    theOneWefound = theOneWefound!.copyWith(newcoordinate: newLocation);
    final Set<Piece> newPieces = pieces.map((e) {
      return e.id == theOneWefound!.id ? theOneWefound! : e;
    }).toSet();
    emit(DragingState(pieces: newPieces, currentPlayer: currentPlayer));
  }

  void dragEnds(Offset whereDragEnds, double pieceRadius, double posRadius) {
    final Piece? theUpdated = gameController.putPieceOnPosition(
      piece: theOneWefound!,
      whereDragEnds: whereDragEnds,
      pieceRadius: pieceRadius,
      posRadius: posRadius,
      actualpositions: positions,
      pieces: pieces,
    );
    if (theUpdated != null) {
      pieces.removeWhere((e) => e.id == theOneWefound!.id);
      pieces.add(theUpdated);
      final Set<Position>? won = gameController.canHeWin(
        currentPlayer: currentPlayer,
        allpositions: positions,
        allpieces: pieces,
      );
      if (won == null) {
        currentPlayer = currentPlayer.toggle();
        theOneWefound = null;
        emit(DragEndState(pieces: pieces, currentPlayer: currentPlayer));
      } else {
        //end game
        theOneWefound = null;
        final int? currentScore = score.score[currentPlayer];
        if (currentScore != null) score.score[currentPlayer] = currentScore + 1;
        emit(
          EndgameState(
            positionHeWon: won,
            currentPlayer: currentPlayer,
            pieces: pieces,
          ),
        );
      }
    } else {
      theOneWefound = null;
      emit(DragEndState(pieces: pieces, currentPlayer: currentPlayer));
    }
  }

  void restart() {
    theOneWefound = null;
    currentPlayer = currentPlayer.toggle();
    positions.clear();
    pieces.clear();
    emit(InitialState(currentPlayer: currentPlayer));
  }
}
//LEGAL MOVES IMPLEMENTATION IS WHAT REMAINING
