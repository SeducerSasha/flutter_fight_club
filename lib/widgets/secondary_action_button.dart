import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';

class SecondaryActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const SecondaryActionButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: FightClubColors.darkGreyText)),
        height: 40,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: FightClubColors.darkGreyText),
        ),
      ),
    );
  }
}
