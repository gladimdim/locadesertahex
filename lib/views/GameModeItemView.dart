import 'package:flutter/material.dart';
import 'package:locadesertahex/components/title_text.dart';
import 'package:locadesertahex/localization/hex_localizations.dart';
import 'package:locadesertahex/models/game_modes.dart';

class GameModeItemView extends StatelessWidget {
  final GameMode mode;
  GameModeItemView({required this.mode});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            mode.iconPath,
            width: 32,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleText(HexLocalizations.of(context)[mode.localizedKeyTitle]),
              Text(HexLocalizations.of(context)[mode.localizedKeyDescription]),
            ],
          ),
        ),
      ],
    );
  }
}
