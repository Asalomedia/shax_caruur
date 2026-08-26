enum Player {
  rock,
  coal;

  Player toggle() => this == Player.rock ? Player.coal : Player.rock;
  @override
  String toString() => this == Player.rock ? "Dhagax" : "Dhuxul";
}
