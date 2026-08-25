import 'package:flutter/foundation.dart' show immutable;

import 'package:shax_caruur/models/position.dart' show Piece, Position;

@immutable
abstract class HomeStates {
  const HomeStates();
}

// initial state
class InitialState extends HomeStates {
  const InitialState();
}

//draging state
class DragingState extends HomeStates {
  final Set<Piece> pieces;
  const DragingState({required this.pieces});
}

//drag is cancelled
class DragEndState extends HomeStates {
  final Set<Piece> pieces;
  const DragEndState({required this.pieces});
}

//end game state
class EndgameState extends HomeStates {
  final Set<Position> positionHeWon;
  const EndgameState({required this.positionHeWon});
}
