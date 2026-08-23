import 'package:flutter/material.dart';
import 'package:shax_caruur/game/player.dart';

class Position {
  final int positionId;
  Offset? coordinate;
  Offset? normalized;
  final PositionsType tpe;
  Player? whoisAt;
  Position({
    this.whoisAt,
    this.coordinate,
    this.normalized,
    required this.positionId,
    required this.tpe,
  });
  Position withPlayer(Player player) {
    return Position(
      positionId: positionId,
      coordinate: coordinate,
      tpe: tpe,
      whoisAt: player,
    );
  }
}

class Positions {
  final List<Position> _shortedPositons = [];
  final List<Position> actualPositions;
  Positions({required this.actualPositions}) {
    for (Position pos in actualPositions) {
      switch (pos.tpe) {
        case PositionsType.topLeft:
          _shortedPositons.add(
            Position(
              normalized: Offset(0, 0),
              tpe: pos.tpe,
              positionId: pos.positionId,
            ),
          );
          break;
        case PositionsType.topCenter:
          _shortedPositons.add(
            Position(
              normalized: Offset(0.5, 0),
              tpe: pos.tpe,
              positionId: pos.positionId,
            ),
          );
          break;
        case PositionsType.topRight:
          _shortedPositons.add(
            Position(
              normalized: Offset(1, 0),
              tpe: pos.tpe,
              positionId: pos.positionId,
            ),
          );
          break;
        case PositionsType.centerLeft:
          _shortedPositons.add(
            Position(
              normalized: Offset(0, 0.5),
              tpe: pos.tpe,
              positionId: pos.positionId,
            ),
          );
          break;
        case PositionsType.center:
          _shortedPositons.add(
            Position(
              normalized: Offset(0.5, 0.5),
              tpe: pos.tpe,
              positionId: pos.positionId,
            ),
          );
          break;
        case PositionsType.centerRight:
          _shortedPositons.add(
            Position(
              normalized: Offset(1, 0.5),
              tpe: pos.tpe,
              positionId: pos.positionId,
            ),
          );
          break;
        case PositionsType.bottomLeft:
          _shortedPositons.add(
            Position(
              normalized: Offset(0, 1),
              tpe: pos.tpe,
              positionId: pos.positionId,
            ),
          );
          break;
        case PositionsType.bottomCenter:
          _shortedPositons.add(
            Position(
              normalized: Offset(0.5, 1),
              tpe: pos.tpe,
              positionId: pos.positionId,
            ),
          );
          break;
        case PositionsType.bottomRight:
          _shortedPositons.add(
            Position(
              normalized: Offset(1, 1),
              tpe: pos.tpe,
              positionId: pos.positionId,
            ),
          );
          break;
      }
    }
  }
  List<Position> get getShortenedPositions => _shortedPositons;
}

enum PositionsType {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}
