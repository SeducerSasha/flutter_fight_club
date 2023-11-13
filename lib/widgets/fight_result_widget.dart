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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'You',
                    style: TextStyle(
                      color: FightClubColors.darkGreyText,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 92,
                    height: 92,
                    child: Image.asset(FightClubImages.youAvatar),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: fightResult.color,
                  borderRadius: BorderRadius.circular(22),
                ),
                height: 44,
                child: Center(
                  child: Text(
                    fightResult.result.toString().toLowerCase(),
                    style: const TextStyle(
                        color: FightClubColors.whiteText, fontSize: 16),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Enemy',
                    style: TextStyle(
                      color: FightClubColors.darkGreyText,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
        ],
      ),
    );
  }
}
