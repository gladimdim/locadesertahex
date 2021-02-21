import 'package:flutter/material.dart';
import 'package:locadesertahex/components/with_map_background_view.dart';
import 'package:locadesertahex/models/app_preferences.dart';
import 'package:locadesertahex/models/game_modes.dart';
import 'package:locadesertahex/models/map_storage_expand.dart';
import 'package:locadesertahex/views/game_expansion_view.dart';

class GameTypeSelectionView extends StatelessWidget {
  Function(Locale locale) onLocaleChange;

  GameTypeSelectionView({this.onLocaleChange});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithMapBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              child: Text("Expansion"),
              onPressed: () => loadExpansionGame(context),
            ),
            TextButton(onPressed: () {}, child: Text("Builder"))
          ],
        ),
      ),
    );
  }

  loadExpansionGame(BuildContext context) async {
    var map = loadMap();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return GameExpansionView(
            map: map,
            onLocaleChange: onLocaleChange,
          );
        },
      ),
    );
  }

  MapStorageExpand loadMap() {
    MapStorageExpand map;
    var loadedJson = AppPreferences.instance.loadMap();
    if (loadedJson == null) {
      map = MapStorageExpand.generate(GAME_MODES.CLASSIC);
    } else {
      map = MapStorageExpand.fromJson(loadedJson);
    }
    return map;
  }
}
