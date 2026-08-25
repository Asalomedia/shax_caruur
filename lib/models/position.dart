import 'package:flutter/material.dart';
import 'package:shax_caruur/models/player.dart';

class Position {
  final int positionId;
  final Offset coordinate;

  Position({required this.positionId, required this.coordinate});
}

class Piece {
  final int id;
  final Player player;
  final Offset coordinate;
  final int? positionId;

  Piece({
    required this.id,
    this.positionId,
    required this.coordinate,
    required this.player,
  });

  Piece copyWith({
    int? newid,
    Player? newplayer,
    Offset? newcoordinate,
    int? posId,
  }) {
    return Piece(
      id: newid ?? id,
      coordinate: newcoordinate ?? coordinate,
      player: newplayer ?? player,
      positionId: posId ?? positionId,
    );
  }
}
