import 'package:flutter/material.dart';
import 'package:locadesertahex/components/image_fitter_view.dart';
import 'package:locadesertahex/localization/hex_localizations.dart';
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
      body: Stack(
        children: [
          ImageFitterView(
            "images/background/map_bw.png",
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 10,
                  child: Wrap(
                    children: GAME_MODES.values.map(
                      (gameMode) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            child: GameModeItemView(
                              mode: GameMode.createMode(gameMode),
                            ),
                            onPressed: () {
                              Navigator.pop(context, gameMode);
                            },
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(HexLocalizations.of(context).labelBack),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
