import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:locadesertahex/loaders/sound_manager.dart';
import 'package:locadesertahex/localization/hex_localizations.dart';
import 'package:locadesertahex/models/app_preferences.dart';
import 'package:locadesertahex/models/map_storage.dart';
import 'package:locadesertahex/views/game_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SoundManager.instance.initSounds();
  await AppPreferences.instance.init();
  // await AppPreferences.instance.removeUILanguage();
  MapStorage map = loadMap();
  runApp(MyApp(map));
}

MapStorage loadMap() {
  MapStorage map;
  var loadedJson = AppPreferences.instance.loadMap();
  if (loadedJson == null) {
    map = MapStorage.generate();
  } else {
    map = MapStorage.fromJson(loadedJson);
  }
  return map;
}

class MyApp extends StatefulWidget {
  final MapStorage map;
  MyApp(this.map);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => MaterialApp(
        locale: _locale,
        localeResolutionCallback: (locale, list) {
          if (HexLocalizations.supportedLanguageCodes.contains(locale.languageCode)) {
            _locale = locale;
            return locale;
          } else {
            _locale = Locale("en");
            return Locale("en");
          }
        },
        onGenerateTitle: (context) {
          return HexLocalizations.of(context).labelTitle;
        },
        localizationsDelegates: [
          const HexLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: HexLocalizations.supportedLanguageCodes.map((sLocale) => Locale(sLocale)),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GameView(
          title: "Hex",
          map: widget.map,
          onLocaleChange: (locale) {
            setState(() {
              _locale = locale;
            });
          },
        ),
      ),
    );
  }
}
