import 'package:flutter/material.dart';
import 'package:shax_caruur/models/player.dart';

class Position {
  final int positionId;
  final Offset coordinate;
  final List<int> legalMovesFromHere;

  Position({
    required this.positionId,
    required this.legalMovesFromHere,
    required this.coordinate,
  });
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Position && other.positionId == positionId;
  }

  @override
  int get hashCode => positionId.hashCode;

  @override
  String toString() {
    return "Position(id:$positionId,coordinate:$coordinate,legalto:${legalMovesFromHere.toString()})";
  }
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Piece && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return "Piece($id,$coordinate,$player)";
  }
}
