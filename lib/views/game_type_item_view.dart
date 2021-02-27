import 'package:flutter/material.dart';
import 'package:locadesertahex/components/title_text.dart';
import 'package:locadesertahex/localization/hex_localizations.dart';
import 'package:locadesertahex/models/game_type.dart';

class GameTypeItemView extends StatelessWidget {
  final GameType gameType;

  GameTypeItemView({this.gameType});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              gameType.thumbnailImagePath,
              width: 128,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText(
                  HexLocalizations.of(context)[gameType.localizedKey],
                ),
                Text(
                  HexLocalizations.of(context)[gameType.localizedDescriptionKey],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
