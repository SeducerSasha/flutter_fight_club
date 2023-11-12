// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';

class FightResultWidget extends StatelessWidget {
  const FightResultWidget({
    Key? key,
    required this.fightResult,
  }) : super(key: key);

  final FightResult fightResult;

  @override
  Widget build(BuildContext context) {
    Color colorBackgroundResult = const Color(0xFF1C79CE);
    if (fightResult.result == FightResult.draw.result) {
      colorBackgroundResult = const Color(0xFF1C79CE);
    } else if (fightResult.result == FightResult.lost.result) {
      colorBackgroundResult = const Color(0xFFEA2C2C);
    } else if (fightResult.result == FightResult.won.result) {
      colorBackgroundResult = const Color.fromRGBO(3, 136, 0, 1);
    }

    return SizedBox(
      height: 140,
      child: Stack(
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: ColoredBox(color: FightClubColors.whiteText)),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        FightClubColors.whiteText,
                        FightClubColors.resultBackground
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: ColoredBox(color: FightClubColors.resultBackground)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 12,
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
              const SizedBox(),
              Column(
                children: [
                  const SizedBox(
                    height: 12,
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
            ],
          ),
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colorBackgroundResult,
                borderRadius: BorderRadius.circular(22),
              ),
              child: SizedBox(
                width: 88,
                height: 44,
                child: Center(
                  child: Text(
                    fightResult.result.toString().toLowerCase(),
                    style: const TextStyle(
                        color: FightClubColors.whiteText, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
