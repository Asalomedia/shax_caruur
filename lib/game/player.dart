class Player {
  final int id;
  final PieceType pieceType;
  final List<Pieces> remainingPieces;

  new({
    required this.id,
    required this.pieceType,
    required this.remainingPieces,
  });
}

class Pieces {
  final int id;
  final PieceType type;

  new({required this.id, required this.type});
}

enum PieceType { rock, coal }
