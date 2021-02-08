import 'package:flutter/material.dart';
import 'package:locadesertahex/models/game_modes.dart';
import 'package:locadesertahex/views/GameModeItemView.dart';

class ModeSelectionView extends StatefulWidget {
  @override
  _ModeSelectionViewState createState() => _ModeSelectionViewState();
}

class _ModeSelectionViewState extends State<ModeSelectionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: GAME_MODES.values.map((gameMode) {
          return InkWell(
            child: GameModeItemView(mode: gameMode,),
            onTap: () {
              Navigator.pop(context, gameMode);
            },
          );
        }).toList(),
      ),
    );
  }
}
