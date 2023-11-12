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
            child: const Text('Statistics'),
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                height: 132,
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<int?>(
                          future: SharedPreferences.getInstance().then(
                              (sharedPrefs) => sharedPrefs.getInt('stats_won')),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data == null) {
                              return const Text(
                                'Won: 0',
                                style: TextStyle(fontSize: 16),
                              );
                            }
                            return Text(
                              'Won: ${snapshot.data}',
                              style: TextStyle(fontSize: 16),
                            );
                          }),
                    ),
                    Expanded(
                      child: FutureBuilder<int?>(
                          future: SharedPreferences.getInstance().then(
                              (sharedPrefs) =>
                                  sharedPrefs.getInt('stats_draw')),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data == null) {
                              return const Text(
                                'Draw: 0',
                                style: TextStyle(fontSize: 16),
                              );
                            }
                            return Text(
                              'Draw: ${snapshot.data}',
                              style: TextStyle(fontSize: 16),
                            );
                          }),
                    ),
                    Expanded(
                      child: FutureBuilder<int?>(
                          future: SharedPreferences.getInstance().then(
                              (sharedPrefs) =>
                                  sharedPrefs.getInt('stats_lost')),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data == null) {
                              return const Text(
                                'Lost: 0',
                                style: TextStyle(fontSize: 16),
                              );
                            }
                            return Text(
                              'Lost: ${snapshot.data}',
                              style: TextStyle(fontSize: 16),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
