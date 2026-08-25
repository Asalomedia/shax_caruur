import 'dart:developer';

import 'package:flutter/material.dart' show Offset;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shax_caruur/game/game_controller.dart';
import 'package:shax_caruur/game/game_controller_intf.dart';
import 'package:shax_caruur/models/position.dart';

import 'package:shax_caruur/state_management/home_states.dart'
    show DragEndState, DragingState, HomeStates, InitialState;

class HomeCubit extends Cubit<HomeStates> {
  final Set<Position> positions = {};
  final Set<Piece> pieces = {};
  Piece? theOneWefound;
  final IController gameController = GameController();
  HomeCubit() : super(InitialState());

  void registerImportantPositions(List<Position> actualpos) {
    positions.addAll(actualpos);
  }

  void registerPieces(List<Piece> orginalpiecel) {
    pieces.addAll(orginalpiecel);
  }

  Piece? findPieceIHit(Offset whereIHit, double pieceRadius) {
    final Piece? piece = gameController.hitPiece(
      whereYouTapped: whereIHit,
      pieceRadius: pieceRadius,
      availablePieces: pieces,
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
    emit(DragingState(pieces: newPieces));
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
    }
    theOneWefound = null;
    emit(DragEndState(pieces: pieces));
  }
}
