import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          Expanded(
              child: Center(
            child: SizedBox(
              height: 132,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<int?>(
                      future: SharedPreferences.getInstance().then(
                          (sharedPrefs) => sharedPrefs.getInt('stats_won')),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Text('Won: 0');
                        }
                        return Text('Won: ${snapshot.data}');
                      }),
                  FutureBuilder<int?>(
                      future: SharedPreferences.getInstance().then(
                          (sharedPrefs) => sharedPrefs.getInt('stats_draw')),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Text('Draw: 0');
                        }
                        return Text('Draw: ${snapshot.data}');
                      }),
                  FutureBuilder<int?>(
                      future: SharedPreferences.getInstance().then(
                          (sharedPrefs) => sharedPrefs.getInt('stats_lost')),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Text('Lost: 0');
                        }
                        return Text('Lost: ${snapshot.data}');
                      }),
                ],
              ),
            ),
          )),
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
