import 'package:flutter/material.dart';
import 'package:locadesertahex/components/title_text.dart';
import 'package:locadesertahex/localization/hex_localizations.dart';
import 'package:locadesertahex/models/other_game.dart';

class OtherGamesView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TitleText(HexLocalizations.of(context).labelOtherGames),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: OtherGame.allGames().map((game) {
          return InkWell(
            onTap: () {
              var locale = HexLocalizations.of(context).locale;
              game.openUrlFor(locale);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(game.image, width: 46),
                Text(HexLocalizations.of(context)[game.titleKey])
              ],
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
