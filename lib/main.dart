// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';
import 'package:flutter_fight_club/fight_club_icons.dart';
import 'package:flutter_fight_club/fight_club_images.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.pressStart2pTextTheme(textTheme),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static const maxLives = 5;
  int yourLives = maxLives;
  int enemysLives = maxLives;
  String textResult = '';

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
            GoButton(
              textButton:
                  yourLives == 0 || enemysLives == 0 ? 'Start new game' : 'Go',
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
      setState(() {
        yourLives = maxLives;
        enemysLives = maxLives;
        // if (yourLives == 0 && enemysLives == 0) {
        //   textResult = 'Drow';
        // }
        // if (enemysLives == 0) {
        //   textResult = '“You won”';
        // }
        // if (yourLives == 0) {
        //   textResult = '“You lost”';
        // }
      });
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

      if (yourLives == 0 && enemysLives == 0) {
        textResult = 'Drow';
      }
      if (enemysLives == 0) {
        textResult = 'You won';
      }
      if (yourLives == 0) {
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

  void _selectattackingBodyPart(final BodyPart value) {
    if (yourLives == 0 || enemysLives == 0) {
      return;
    }
    setState(() {
      attackingBodyPart = value;
    });
  }
}

class GoButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String textButton;

  const GoButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 40,
          child: ColoredBox(
            color: color,
            child: Center(
              child: Text(
                textButton.toUpperCase(),
                style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: FightClubColors.whiteText),
              ),
            ),
          ),
        ),
      ),
    );
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
                  child: ColoredBox(
                color: FightClubColors.resultBackground,
              )),
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
            child: ColoredBox(
              color: Color(0xFF4DC839),
              child: SizedBox(
                width: 44,
                height: 44,
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
        child: ColoredBox(
          color: selected
              ? FightClubColors.blueButton
              : FightClubColors.greyButton,
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
