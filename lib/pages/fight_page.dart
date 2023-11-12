import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_icons.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FightPage extends StatefulWidget {
  const FightPage({super.key});

  @override
  State<FightPage> createState() => FightPageState();
}

class FightPageState extends State<FightPage> {
  static const maxLives = 5;
  int yourLives = maxLives;
  int enemysLives = maxLives;
  String textResult = '';
  int countDraw = 0;
  int countLost = 0;
  int countWon = 0;

  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  BodyPart whatEnemyDefend = BodyPart.random();
  BodyPart whatEnemyAttack = BodyPart.random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FightersInfo(
              maxLivesCount: maxLives,
              yourLivesCount: yourLives,
              enemyLivesCount: enemysLives,
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ColoredBox(
                  color: FightClubColors.resultBackground,
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        textResult,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: FightClubColors.blackButton,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ControlsWidget(
              attackingBodyPart: attackingBodyPart,
              defendingBodyPart: defendingBodyPart,
              selectattackingBodyPart: _selectattackingBodyPart,
              selectdefendingBodyPart: _selectdefendingBodyPart,
            ),
            const SizedBox(height: 14),
            ActionButton(
              textButton: yourLives == 0 || enemysLives == 0 ? 'Back' : 'Go',
              onTap: _onGoButtonClicked,
              color: _getGoButtonColor(),
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }

  void getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? statsDraw = prefs.getInt('stats_draw');
    int? statsLost = prefs.getInt('stats_lost');
    int? statsWon = prefs.getInt('stats_won');

    if (statsDraw == null) {
      countDraw = 0;
    } else {
      countDraw = statsDraw;
    }

    if (statsLost == null) {
      countLost = 0;
    } else {
      countLost = statsLost;
    }
    if (statsWon == null) {
      countWon = 0;
    } else {
      countWon = statsWon;
    }
  }

  Color _getGoButtonColor() {
    if (yourLives == 0 || enemysLives == 0) {
      return FightClubColors.blackButton;
    } else if (defendingBodyPart == null || attackingBodyPart == null) {
      return FightClubColors.greyButton;
    } else {
      return FightClubColors.blackButton;
    }
  }

  void _onGoButtonClicked() {
    if (yourLives == 0 || enemysLives == 0) {
      Navigator.of(context).pop();
    } else if (defendingBodyPart != null && attackingBodyPart != null) {
      _resetBodyPart();
    }
  }

  void _resetBodyPart() {
    setState(() {
      final bool enemyLoseLife = defendingBodyPart != whatEnemyAttack;
      final bool yourLoseLife = attackingBodyPart != whatEnemyDefend;

      if (enemyLoseLife) {
        enemysLives -= 1;
      }

      if (yourLoseLife) {
        yourLives -= 1;
      }

      if (yourLives == 0 || enemysLives == 0) {
        final FightResult? fightResult =
            FightResult.getFightResult(yourLives, enemysLives);

        if (fightResult != null) {
          SharedPreferences.getInstance().then((sharedPrefs) =>
              sharedPrefs.setString('LastFightResult', fightResult.result));
          if (fightResult == FightResult.draw) {
            SharedPreferences.getInstance().then(
                (sharedPrefs) => sharedPrefs.setInt('stats_draw', countDraw++));
          }
          if (fightResult == FightResult.lost) {
            SharedPreferences.getInstance().then(
                (sharedPrefs) => sharedPrefs.setInt('stats_lost', countLost++));
          }
          if (fightResult == FightResult.won) {
            SharedPreferences.getInstance().then(
                (sharedPrefs) => sharedPrefs.setInt('stats_won', countWon++));
          }
        }
      }
      textResult = _textResult();
      whatEnemyDefend = BodyPart.random();
      whatEnemyAttack = BodyPart.random();

      defendingBodyPart = null;
      attackingBodyPart = null;
    });
  }

  void _selectdefendingBodyPart(final BodyPart value) {
    if (yourLives == 0 || enemysLives == 0) {
      return;
    }
    setState(() {
      defendingBodyPart = value;
    });
  }

  String _textResult() {
    if (yourLives == 0 && enemysLives == 0) {
      textResult = 'Draw';
    }
    if (enemysLives == 0 && yourLives > 0) {
      textResult = 'You won';
    }
    if (yourLives == 0 && enemysLives > 0) {
      textResult = 'You lost';
    }

    if (yourLives != 0 && enemysLives != 0) {
      if (attackingBodyPart == whatEnemyDefend) {
        textResult = 'Your attack was blocked.\n\n';
      } else {
        textResult =
            'You hit enemy’s ${attackingBodyPart!.name.toLowerCase()}.\n\n';
      }

      if (whatEnemyAttack == defendingBodyPart) {
        textResult = '$textResult Enemy’s attack was blocked.';
      } else {
        textResult =
            '$textResult Enemy hit your ${whatEnemyAttack.name.toLowerCase()}.';
      }
    }

    return textResult;
  }

  void _selectattackingBodyPart(final BodyPart value) {
    if (yourLives == 0 || enemysLives == 0) {
      return;
    }
    setState(() {
      attackingBodyPart = value;
    });
  }
}

class ControlsWidget extends StatelessWidget {
  const ControlsWidget(
      {super.key,
      required this.defendingBodyPart,
      required this.attackingBodyPart,
      required this.selectdefendingBodyPart,
      required this.selectattackingBodyPart});

  final BodyPart? defendingBodyPart;
  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectdefendingBodyPart;
  final ValueSetter<BodyPart> selectattackingBodyPart;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            children: [
              const SizedBox(height: 40),
              SizedBox(
                height: 40,
                child: Center(
                    child: Text('Defend'.toUpperCase(),
                        style: const TextStyle(
                          color: FightClubColors.blackButton,
                        ))),
              ),
              const SizedBox(height: 13),
              BodyPartButton(
                  bodyPart: BodyPart.head,
                  selected: defendingBodyPart == BodyPart.head,
                  bodyPartSetter: selectdefendingBodyPart),
              const SizedBox(height: 14),
              BodyPartButton(
                  bodyPart: BodyPart.torso,
                  selected: defendingBodyPart == BodyPart.torso,
                  bodyPartSetter: selectdefendingBodyPart),
              const SizedBox(height: 14),
              BodyPartButton(
                  bodyPart: BodyPart.legs,
                  selected: defendingBodyPart == BodyPart.legs,
                  bodyPartSetter: selectdefendingBodyPart),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              const SizedBox(height: 40),
              SizedBox(
                height: 40,
                child: Center(
                    child: Text(
                  'Attack'.toUpperCase(),
                  style: const TextStyle(
                    color: FightClubColors.blackButton,
                  ),
                )),
              ),
              const SizedBox(height: 13),
              BodyPartButton(
                  bodyPart: BodyPart.head,
                  selected: attackingBodyPart == BodyPart.head,
                  bodyPartSetter: selectattackingBodyPart),
              const SizedBox(height: 14),
              BodyPartButton(
                  bodyPart: BodyPart.torso,
                  selected: attackingBodyPart == BodyPart.torso,
                  bodyPartSetter: selectattackingBodyPart),
              const SizedBox(height: 14),
              BodyPartButton(
                  bodyPart: BodyPart.legs,
                  selected: attackingBodyPart == BodyPart.legs,
                  bodyPartSetter: selectattackingBodyPart),
            ],
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}

class FightersInfo extends StatelessWidget {
  final int maxLivesCount;
  final int yourLivesCount;
  final int enemyLivesCount;
  const FightersInfo({
    super.key,
    required this.maxLivesCount,
    required this.yourLivesCount,
    required this.enemyLivesCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: ColoredBox(color: FightClubColors.whiteText)),
              Expanded(
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                FightClubColors.whiteText,
                FightClubColors.resultBackground
              ])))),
              Expanded(
                  child: ColoredBox(color: FightClubColors.resultBackground)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LivesWidget(
                overallLivesCount: maxLivesCount,
                currentLivesCount: yourLivesCount,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'You',
                    style: TextStyle(
                      color: FightClubColors.blackButton,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: 92,
                    height: 92,
                    child: Image.asset(FightClubImages.youAvatar),
                  ),
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Enemy',
                    style: TextStyle(
                      color: FightClubColors.blackButton,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: 92,
                    height: 92,
                    child: Image.asset(FightClubImages.enemyAvatar),
                  ),
                ],
              ),
              LivesWidget(
                  overallLivesCount: maxLivesCount,
                  currentLivesCount: enemyLivesCount),
            ],
          ),
          const Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: FightClubColors.blueButton, shape: BoxShape.circle),
              child: SizedBox(
                width: 44,
                height: 44,
                child: Center(
                    child: Text(
                  'vs',
                  style:
                      TextStyle(color: FightClubColors.whiteText, fontSize: 16),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LivesWidget extends StatelessWidget {
  const LivesWidget(
      {super.key,
      required this.overallLivesCount,
      required this.currentLivesCount})
      : assert(overallLivesCount >= 1),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount);

  final int overallLivesCount;
  final int currentLivesCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(overallLivesCount, (index) {
        if (index < currentLivesCount) {
          return Padding(
            padding: index < overallLivesCount - 1
                ? const EdgeInsets.only(bottom: 4)
                : const EdgeInsets.only(bottom: 0),
            child: Image.asset(
              FightClubIcons.heartFull,
              width: 18,
              height: 18,
            ),
          );
        } else {
          return Padding(
            padding: index < overallLivesCount - 1
                ? const EdgeInsets.only(bottom: 4)
                : const EdgeInsets.only(bottom: 0),
            child: Image.asset(
              FightClubIcons.heartEmpty,
              width: 18,
              height: 18,
            ),
          );
        }
      }),
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._('Head');
  static const torso = BodyPart._('Torso');
  static const legs = BodyPart._('Legs');

  @override
  String toString() => 'BodyPart(name: $name)';

  static const List<BodyPart> _values = [head, torso, legs];
  static BodyPart random() {
    return _values[Random().nextInt(_values.length)];
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton({
    super.key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
                color: FightClubColors.darkGreyText, width: selected ? 0 : 2),
            color: selected ? FightClubColors.blueButton : Colors.transparent,
          ),
          child: Center(
              child: Text(
            bodyPart.name.toUpperCase(),
            style: TextStyle(
              color: selected
                  ? FightClubColors.whiteText
                  : FightClubColors.blackButton,
            ),
          )),
        ),
      ),
    );
  }
}
