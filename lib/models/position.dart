import 'package:flutter/material.dart';
import 'package:shax_caruur/models/piece.dart';
import 'package:shax_caruur/models/player.dart' show Player;

class Position {
  final int positionId;
  final Offset coordinate;
  final Piece? piece;

  const Position({
    required this.positionId,
    required this.coordinate,
    this.piece,
  });
}
