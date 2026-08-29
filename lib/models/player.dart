enum Player {
  red,
  green;

  Player toggle() => this == Player.red ? Player.green : Player.red;
  @override
  String toString() => this == Player.red ? "Red" : "Green";
}
