import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:locadesertahex/components/hex_surface.dart';
import 'package:locadesertahex/loaders/sound_manager.dart';
import 'package:locadesertahex/models/app_preferences.dart';
import 'package:locadesertahex/models/map_storage.dart';
import 'package:locadesertahex/views/game_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SoundManager.instance.initSounds();
  await AppPreferences.instance.init();
  // await AppPreferences.instance.removeMap();
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

class MyApp extends StatelessWidget {
  final MapStorage map;

  MyApp(this.map);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loca Deserta: Hex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameView(title: "Hex", map: map),
    );
  }
}

