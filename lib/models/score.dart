import 'package:shax_caruur/models/player.dart';

class Score {
  final Map<Player, int> score;

  Score({required this.score});
  @override
  String toString() {
    return "Score(score:$score)";
  }

  @override
  int get hashCode => score.values.hashCode;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Score && other.score.values == score.values;
  }
}
