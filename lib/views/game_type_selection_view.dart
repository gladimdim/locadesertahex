import 'package:flutter/material.dart';
import 'package:locadesertahex/components/with_map_background_view.dart';
import 'package:locadesertahex/models/app_preferences.dart';
import 'package:locadesertahex/models/game_modes.dart';
import 'package:locadesertahex/builder/models/map_storage_builder.dart';
import 'package:locadesertahex/models/map_storage_expansion.dart';
import 'package:locadesertahex/builder/views/game_builder_view.dart';
import 'package:locadesertahex/views/game_expansion_view.dart';

class GameTypeSelectionView extends StatelessWidget {
  final Function(Locale locale) onLocaleChange;

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
            TextButton(onPressed: () => loadBuilderGame(context), child: Text("Builder"))
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

  loadBuilderGame(BuildContext context) async {
    var storage = MapStorageBuilder();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return GameBuilderView(
            storage: storage,
            onLocaleChange: onLocaleChange,
          );
        },
      ),
    );
  }

  MapStorageExpansion loadMap() {
    MapStorageExpansion map;
    var loadedJson = AppPreferences.instance.loadMap();
    if (loadedJson == null) {
      map = MapStorageExpansion.generate(GAME_MODES.CLASSIC);
    } else {
      map = MapStorageExpansion.fromJson(loadedJson);
    }
    return map;
  }
}
