import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:locadesertahex/loaders/sound_manager.dart';
import 'package:locadesertahex/localization/hex_localizations.dart';
import 'package:locadesertahex/models/app_preferences.dart';
import 'package:locadesertahex/models/game_modes.dart';
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
    map = MapStorage.generate(GAME_MODES.CLASSIC);
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
    return MaterialApp(
      theme: mainTheme,
      locale: _locale,
      localeResolutionCallback: (locale, list) {
        if (HexLocalizations.supportedLanguageCodes
            .contains(locale.languageCode)) {
          _locale = locale;
        } else {
          _locale = Locale("en");
        }
        return _locale;
      },
      onGenerateTitle: (context) {
        return HexLocalizations.of(context).labelTitle;
      },
      localizationsDelegates: [
        const HexLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: HexLocalizations.supportedLanguageCodes
          .map((sLocale) => Locale(sLocale)),
      home: GameView(
        title: "Hex",
        map: widget.map,
        onLocaleChange: (locale) {
          setState(() {
            _locale = locale;
          });
        },
      ),
    );
  }
}

var mainTheme = ThemeData(
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.resolveWith((states) {
        return GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        );
      }),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered))
            return Colors.green[900];
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed))
            return Colors.green[600];
          return Colors
              .green[400]; // Defer to the widget's default.
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.hovered)) {
          return Colors.green[300];
        } else if (states.contains(MaterialState.pressed)) {
          return Colors.blue[500];
        }
        return Colors.black;
      }),
    ),
  ),
  textTheme: TextTheme(
    bodyText2: GoogleFonts.tenorSans(
      textStyle: TextStyle(
        fontSize: 18,
        // color: Colors.green[800],
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
);
