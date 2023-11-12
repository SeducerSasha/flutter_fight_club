import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: const Text('Statistics'),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SecondaryActionButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
                color: Colors.transparent,
                text: 'Back'),
          ),
        ],
      )),
    );
  }
}
