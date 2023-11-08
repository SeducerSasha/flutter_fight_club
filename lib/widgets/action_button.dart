import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String textButton;

  const ActionButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        color: color,
        child: Text(
          textButton.toUpperCase(),
          style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: FightClubColors.whiteText),
        ),
      ),
    );
  }
}
