import 'package:flutter/material.dart';
import 'package:locadesertahex/components/expansion/hex_surface.dart';
import 'package:locadesertahex/hexgrid/funcs.dart';
import 'package:locadesertahex/localization/hex_localizations.dart';
import 'package:locadesertahex/models/abstract/map_storage.dart';
import 'package:locadesertahex/models/app_preferences.dart';
import 'package:locadesertahex/views/mode_selection_view.dart';
import 'package:locadesertahex/views/settings_view.dart';

class GameExpansionView extends StatefulWidget {
  final MapStorageExpansion storage;
  final String title;
  final Function(Locale) onLocaleChange;

  GameExpansionView({Key key, this.title, this.storage, this.onLocaleChange});

  @override
  _GameExpansionViewState createState() => _GameExpansionViewState();
}

class _GameExpansionViewState extends State<GameExpansionView> {
  MapStorageExpansion storage;

  @override
  void initState() {
    super.initState();
    storage = widget.storage;
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
              dimension: MAP_DIMENSION,
              size: HEX_SIZE,
              storage: storage,
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
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StreamBuilder(
                                stream: storage.changes,
                                builder: (context, data) => Text(
                                    "${HexLocalizations.of(context).labelPoints}: ${storage.totalPoints}"),
                              ),
                              if (!storage.isGameOver()) Text(
                                HexLocalizations.of(context)[storage.gameMode
                                    .localizedKeyTitle],
                              ),

                              if (storage.isGameOver())
                                Text(
                                    HexLocalizations.of(context).labelGameOver),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
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
                                      storage = MapStorageExpansion.generate(mode);
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
                                    storage.shuffle();
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
