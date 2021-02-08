import 'package:flutter/material.dart';
import 'package:locadesertahex/components/title_text.dart';
import 'package:locadesertahex/models/game_modes.dart';

class GameModeItemView extends StatelessWidget {
  final GAME_MODES mode;
  GameModeItemView({this.mode});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleText(mode.toString()),
        Row(
          children: [
            Text("Something about this mode"),
            Text("Difficulty: easy"),
          ],
        ),
      ],
    );
  }
}
