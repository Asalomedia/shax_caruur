import 'package:flutter/foundation.dart' show immutable;

import 'package:shax_caruur/models/position.dart' show Position;

@immutable
abstract class HomeStates {
  const HomeStates();
}

// initial state
class InitialState extends HomeStates {
  const InitialState();
}

//put items state
class PuttingState extends HomeStates {
  final Set<Position> positionsOccupied;
  const PuttingState({required this.positionsOccupied});
}

//moving pieces state
class MotionState extends HomeStates {
  final Set<Position> positionsOccupied;
  const MotionState({required this.positionsOccupied});
}

//end game state
class EndgameState extends HomeStates {
  final Set<Position> positionHeWon;
  const EndgameState({required this.positionHeWon});
}
