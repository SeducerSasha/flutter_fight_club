// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';

class FightResult {
  final String result;
  final Color color;

  const FightResult._(this.result, this.color);

  static const won = FightResult._('Won', FightClubColors.green);
  static const lost = FightResult._('Lost', FightClubColors.red);
  static const draw = FightResult._('Draw', FightClubColors.blueButton);

  static returnFightResult(final String result) {
    if (result == 'Won') {
      return won;
    } else if (result == 'Lost') {
      return lost;
    } else {
      return draw;
    }
  }

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
