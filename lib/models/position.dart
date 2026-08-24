import 'package:flutter/material.dart';
import 'package:shax_caruur/models/player.dart';

class Position {
  final int positionId;
  final Offset coordinate;
  Piece? piece;

  Position({required this.positionId, this.piece, required this.coordinate});

  void putPiece(Piece piece) {
    piece.coordinate = coordinate;
    this.piece = piece;
  }
}

class Piece {
  final int id;
  final Player player;
  Offset coordinate;

  Piece({required this.id, required this.coordinate, required this.player});
}
