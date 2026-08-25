import 'package:flutter/foundation.dart' show immutable;
import 'package:shax_caruur/models/player.dart';

import 'package:shax_caruur/models/position.dart' show Piece, Position;

@immutable
abstract class HomeStates {
  final Player currentPlayer;
  const HomeStates({required this.currentPlayer});
}

// initial state
class InitialState extends HomeStates {
  const InitialState({required super.currentPlayer});
}

//draging state
class DragingState extends HomeStates {
  final Set<Piece> pieces;
  const DragingState({required this.pieces, required super.currentPlayer});
}

//drag is cancelled
class DragEndState extends HomeStates {
  final Set<Piece> pieces;
  const DragEndState({required this.pieces, required super.currentPlayer});
}

//end game state
class EndgameState extends HomeStates {
  final Set<Position> positionHeWon;
  const EndgameState({
    required this.positionHeWon,
    required super.currentPlayer,
  });
}
