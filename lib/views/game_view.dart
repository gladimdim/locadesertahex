import 'package:flutter/material.dart';
import 'package:locadesertahex/components/hex_surface.dart';
import 'package:locadesertahex/localization/hex_localizations.dart';
import 'package:locadesertahex/models/app_preferences.dart';
import 'package:locadesertahex/models/map_storage.dart';
import 'package:locadesertahex/views/mode_selection_view.dart';
import 'package:locadesertahex/views/settings_view.dart';

class GameView extends StatefulWidget {
  final MapStorage map;
  final String title;
  final Function(Locale) onLocaleChange;

  GameView({Key key, this.title, this.map, this.onLocaleChange});

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final double size = 120;
  final double dimension = 6000;
  MapStorage map;

  void initState() {
    map = widget.map;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var soundOn = AppPreferences.instance.getSoundEnabled();
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: HexSurface(
              dimension: dimension,
              size: size,
              storage: map,
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 50,
                color: Colors.white.withAlpha(155),
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 12.0, left: 8, right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.green[800], width: 2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              StreamBuilder(
                                stream: map.changes,
                                builder: (context, data) => Text(
                                    "${HexLocalizations.of(context).labelPoints}: ${map.totalPoints}"),
                              ),
                              Text(
                                HexLocalizations.of(context)[map.gameMode.localizedKeyTitle],
                              ),
                              if (map.isGameOver())
                                Text(
                                    HexLocalizations.of(context).labelGameOver),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.refresh_outlined,
                                  color: Colors.green[700],
                                ),
                                tooltip:
                                    HexLocalizations.of(context).tooltipNewGame,
                                onPressed: () async {
                                  var mode = await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ModeSelectionView();
                                  }));
                                  if (mode != null) {
                                    setState(() {
                                      map = MapStorage.generate(mode);
                                    });
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.shuffle,
                                  size: 24,
                                  color: Colors.green[700],
                                ),
                                tooltip:
                                    HexLocalizations.of(context).tooltipShuffle,
                                onPressed: () {
                                  setState(() {
                                    map.shuffle();
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  soundOn ? Icons.music_note : Icons.music_off,
                                  // size: 24,
                                  color: Colors.green[700],
                                ),
                                tooltip:
                                    HexLocalizations.of(context).tooltipSounds,
                                onPressed: () async {
                                  var current =
                                      AppPreferences.instance.getSoundEnabled();
                                  await AppPreferences.instance
                                      .setSoundEnabled(!current);
                                  setState(() {});
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.help,
                                  // size: 24,
                                  color: Colors.green[700],
                                ),
                                tooltip: HexLocalizations.of(context)
                                    .tooltipSettings,
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SettingsView(
                                        onLocaleChange: widget.onLocaleChange,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
