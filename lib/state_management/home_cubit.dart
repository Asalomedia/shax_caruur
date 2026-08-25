import 'dart:developer';

import 'package:flutter/material.dart' show Offset;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shax_caruur/game/game_controller.dart';
import 'package:shax_caruur/game/game_controller_intf.dart';
import 'package:shax_caruur/models/player.dart';
import 'package:shax_caruur/models/position.dart';

import 'package:shax_caruur/state_management/home_states.dart'
    show DragEndState, DragingState, HomeStates, InitialState;

Player currentPlayer = Player.rock;

class HomeCubit extends Cubit<HomeStates> {
  final Set<Position> positions = {};
  final Set<Piece> pieces = {};
  Piece? theOneWefound;
  final IController gameController = GameController();
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
      currentPlayer = currentPlayer.toggle();
    }
    theOneWefound = null;
    emit(DragEndState(pieces: pieces, currentPlayer: currentPlayer));
  }
}
//LEGAL MOVES IMPLEMENTATION IS WHAT REMAINING
