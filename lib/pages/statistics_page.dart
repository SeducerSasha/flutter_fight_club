import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: const Text(
              'Statistics',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: FightClubColors.darkGreyText),
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          FutureBuilder<SharedPreferences>(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox();
                }
                final SharedPreferences sharedPrefs = snapshot.data!;
                return Column(
                  children: [
                    Text(
                      'Won: ${sharedPrefs.getInt('stats_won') ?? 0}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Draw: ${sharedPrefs.getInt('stats_draw') ?? 0}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Lost: ${sharedPrefs.getInt('stats_lost') ?? 0}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                );
              }),
          const Expanded(child: SizedBox.shrink()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SecondaryActionButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
                text: 'Back'),
          ),
        ],
      )),
    );
  }
}
