import 'package:flutter/material.dart';
import 'package:locadesertahex/components/hex_surface.dart';
import 'package:locadesertahex/components/title_text.dart';
import 'package:locadesertahex/localization/hex_localizations.dart';
import 'package:locadesertahex/models/map_storage.dart';
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
                height: 44,
                color: Colors.white.withAlpha(155),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.refresh,
                          size: 24,
                          color: Colors.green[700],
                        ),
                        onPressed: () {
                          setState(() {
                            map = MapStorage.generate();
                          });
                        },
                      ),
                      StreamBuilder(
                        stream: map.changes,
                        builder: (context, data) => TitleText(
                            "${HexLocalizations.of(context).labelPoints}: ${map.totalPoints}"),
                      ),
                      if (map.isGameOver())
                        TitleText(HexLocalizations.of(context).labelGameOver),
                      IconButton(
                        icon: Icon(
                          Icons.shuffle,
                          size: 24,
                          color: Colors.green[700],
                        ),
                        onPressed: () {
                          setState(() {
                            map.shuffle();
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.settings,
                          size: 24,
                          color: Colors.green[700],
                        ),
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
