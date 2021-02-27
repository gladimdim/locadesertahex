import 'package:flutter/material.dart';
import 'package:locadesertahex/components/title_text.dart';
import 'package:locadesertahex/components/with_map_background_view.dart';
import 'package:locadesertahex/localization/hex_localizations.dart';
import 'package:locadesertahex/models/abstract/map_storage.dart';
import 'package:locadesertahex/models/app_preferences.dart';
import 'package:locadesertahex/models/game_modes.dart';
import 'package:locadesertahex/builder/views/game_builder_view.dart';
import 'package:locadesertahex/models/game_type.dart';
import 'package:locadesertahex/views/game_expansion_view.dart';
import 'package:locadesertahex/views/game_type_item_view.dart';

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
            Container(
              color: Colors.green[400],
              child: Center(
                  child: TitleText(
                      HexLocalizations.of(context).labelPickGameType)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: GameTypeItemView(gameType: GameTypeExpansion()),
                onPressed: () => loadExpansionGame(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () => loadBuilderGame(context),
                child: GameTypeItemView(gameType: GameTypeBuilder()),
              ),
            )
          ],
        ),
      ),
    );
  }

  loadExpansionGame(BuildContext context) async {
    var map = loadExpansionMap();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return GameExpansionView(
            storage: map,
            onLocaleChange: onLocaleChange,
          );
        },
      ),
    );
  }

  loadBuilderGame(BuildContext context) async {
    var storage = loadBuilderMap();
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

  MapStorageExpansion loadExpansionMap() {
    MapStorageExpansion map;
    var loadedJson = AppPreferences.instance.loadExpansionMap();
    if (loadedJson == null) {
      map = MapStorageExpansion.generate(GAME_MODES.CLASSIC);
    } else {
      map = MapStorageExpansion.fromJson(loadedJson);
    }
    return map;
  }

  MapStorageBuilder loadBuilderMap() {
    MapStorageBuilder map;
    var loadedJson = AppPreferences.instance.loadBuilderMap();
    if (loadedJson == null) {
      map = MapStorageBuilder.generate(GAME_MODES.CLASSIC);
    } else {
      map = MapStorageBuilder.fromJson(loadedJson);
    }
    return map;
  }
}
