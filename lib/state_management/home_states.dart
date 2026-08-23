import 'package:flutter/foundation.dart' show immutable;
import 'package:shax_caruur/game/player.dart';
import 'package:shax_caruur/game/positions.dart';

@immutable
abstract class HomeStates {
  final Player currentPlayer;

  const HomeStates({required this.currentPlayer});
}

// initial state
class InitialState extends HomeStates {
  const InitialState({required super.currentPlayer});
}

//put items state
class PuttingState extends HomeStates {
  final List<Position> positionsOccupied;
  const PuttingState({
    required super.currentPlayer,
    required this.positionsOccupied,
  });
}

//moving pieces state
class MotionState extends HomeStates {
  final List<Position> positionsOccupied;
  const MotionState({
    required super.currentPlayer,
    required this.positionsOccupied,
  });
}

//end game state
class EndgameState extends HomeStates {
  final List<Position> positionHeWon;
  const EndgameState({
    required super.currentPlayer,
    required this.positionHeWon,
  });
}
