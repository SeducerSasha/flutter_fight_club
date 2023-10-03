// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(213, 222, 240, 1),
        body: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Center(child: Text('You')),
                    Center(child: Text('1')),
                    Center(child: Text('1')),
                    Center(child: Text('1')),
                    Center(child: Text('1')),
                    Center(child: Text('1')),
                  ],
                )),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Center(child: Text('Enemy')),
                    Center(child: Text('1')),
                    Center(child: Text('1')),
                    Center(child: Text('1')),
                    Center(child: Text('1')),
                    Center(child: Text('1')),
                  ],
                )),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Row(
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
                        child: Center(child: Text('Defend'.toUpperCase())),
                      ),
                      const SizedBox(height: 13),
                      BodyPartButton(
                          bodyPart: BodyPart.head,
                          selected: defendingBodyPart == BodyPart.head,
                          bodyPartSetter: _selectdefendingBodyPart),
                      const SizedBox(height: 14),
                      BodyPartButton(
                          bodyPart: BodyPart.torso,
                          selected: defendingBodyPart == BodyPart.torso,
                          bodyPartSetter: _selectdefendingBodyPart),
                      const SizedBox(height: 14),
                      BodyPartButton(
                          bodyPart: BodyPart.legs,
                          selected: defendingBodyPart == BodyPart.legs,
                          bodyPartSetter: _selectdefendingBodyPart),
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
                        child: Center(child: Text('Attack'.toUpperCase())),
                      ),
                      const SizedBox(height: 13),
                      BodyPartButton(
                          bodyPart: BodyPart.head,
                          selected: attackingBodyPart == BodyPart.head,
                          bodyPartSetter: _selectattackingBodyPart),
                      const SizedBox(height: 14),
                      BodyPartButton(
                          bodyPart: BodyPart.torso,
                          selected: attackingBodyPart == BodyPart.torso,
                          bodyPartSetter: _selectattackingBodyPart),
                      const SizedBox(height: 14),
                      BodyPartButton(
                          bodyPart: BodyPart.legs,
                          selected: attackingBodyPart == BodyPart.legs,
                          bodyPartSetter: _selectattackingBodyPart),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => {
                      if (defendingBodyPart != null &&
                          attackingBodyPart != null)
                        {_resetBodyPart()}
                    },
                    child: SizedBox(
                      height: 40,
                      child: ColoredBox(
                        color: (defendingBodyPart == null ||
                                attackingBodyPart == null)
                            ? const Color.fromRGBO(0, 0, 0, 0.38)
                            : const Color.fromRGBO(0, 0, 0, 0.87),
                        child: Center(
                          child: Text(
                            'Go'.toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }

  void _resetBodyPart() {
    setState(() {
      defendingBodyPart = null;
      attackingBodyPart = null;
    });
  }

  void _selectdefendingBodyPart(final BodyPart value) {
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectattackingBodyPart(final BodyPart value) {
    setState(() {
      attackingBodyPart = value;
    });
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
              ? const Color.fromRGBO(28, 121, 206, 1)
              : const Color.fromRGBO(0, 0, 0, 0.38),
          child: Center(child: Text(bodyPart.name.toUpperCase())),
        ),
      ),
    );
  }
}
