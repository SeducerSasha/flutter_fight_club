// ignore_for_file: public_member_api_docs, sort_constructors_first
class FightResult {
  final String result;

  const FightResult._(this.result);

  static const won = FightResult._('Won');
  static const lost = FightResult._('Lost');
  static const draw = FightResult._('Draw');

  static FightResult? getFightResult(
      final int yourLives, final int enemysLives) {
    if (yourLives == 0 && enemysLives == 0) {
      return draw;
    } else if (yourLives > 0) {
      return won;
    } else if (enemysLives > 0) {
      return lost;
    }

    return null;
  }

  @override
  String toString() => 'FightResult(result: $result)';
}
