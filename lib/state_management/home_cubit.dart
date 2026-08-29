import 'package:flutter/material.dart' show Offset, Size;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shax_caruur/game/game_controller.dart';
import 'package:shax_caruur/game/game_controller_intf.dart';
import 'package:shax_caruur/models/player.dart';
import 'package:shax_caruur/models/position.dart';
import 'package:shax_caruur/models/score.dart';

import 'package:shax_caruur/state_management/home_states.dart'
    show DragEndState, DragingState, EndgameState, HomeStates, InitialState;

Player currentPlayer = Player.red;

class HomeCubit extends Cubit<HomeStates> {
  final Score score = Score(score: {Player.red: 0, Player.green: 0});
  final IController gameController = GameController();
  HomeCubit() : super(InitialState(currentPlayer: currentPlayer));

  void setSize(Size totalSize) {
    gameController.setSize(totalSize);
  }

  void registerPositionsAndPieces() {
    gameController.fillPositionsAndPieces();
  }

  void dragStart(Offset whereIHit, Player currentPlayer) {
    gameController.hitPiece(
      whereYouTapped: whereIHit,
      currentPlayer: currentPlayer,
    );
  }

  void updatePieceLocation(Offset newLocation) {
    final Piece theOneweFound = gameController.getTheOneWefound!;
    gameController.setTheOneWeFound = theOneweFound.copyWith(
      newcoordinate: newLocation,
    );
    final Set<Piece> newPieces = gameController.getPieces.map((e) {
      return e.id == theOneweFound.id ? theOneweFound : e;
    }).toSet();
    emit(DragingState(pieces: newPieces, currentPlayer: currentPlayer));
  }

  void dragEnds(Offset whereDragEnds) {
    final bool successfullyPut = gameController.putPieceOnPosition(
      whereDragEnds: whereDragEnds,
    );
    if (successfullyPut) {
      final Set<Position>? wline = gameController.canHeWin(
        currentPlayer: currentPlayer,
      );
      if (wline == null) {
        currentPlayer = currentPlayer.toggle();
        emit(
          DragEndState(
            pieces: gameController.getPieces,
            currentPlayer: currentPlayer,
          ),
        );
      } else {
        //he won
        int? s = score.score[currentPlayer];
        if (s != null) score.score[currentPlayer] = s + 1;
        emit(
          EndgameState(
            positionHeWon: wline,
            pieces: gameController.getPieces,
            currentPlayer: currentPlayer,
          ),
        );
      }
    } else {
      //drag ends but player will not change he failed to put it in good position
      emit(
        DragEndState(
          pieces: gameController.getPieces,
          currentPlayer: currentPlayer,
        ),
      );
    }
  }

  void restart() {
    gameController.restart();
    currentPlayer = currentPlayer.toggle();
    emit(InitialState(currentPlayer: currentPlayer));
  }

  void dispose() {
    gameController.dispose();
  }
}
