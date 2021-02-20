import 'dart:collection';
import 'dart:math';

import 'package:locadesertahex/hexgrid/funcs.dart';
import 'package:locadesertahex/models/abstract/map_storage.dart';
import 'package:locadesertahex/models/app_preferences.dart';
import 'package:locadesertahex/models/city_hex.dart';
import 'package:locadesertahex/models/game_modes.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class MapStorageExpand extends MapStorage {
  Map<String, Hex> map;
  GameMode gameMode;

  MapStorageExpand({this.map, this.gameMode}):super(map: map, gameMode: gameMode) {
    gameMode = gameMode ?? GameModeClassic();
    cities = gameMode.cities;
  }

  void processRings(radius) {
    Tuple2<bool, List<Hex>> result = ringClosedAt(radius);
    if (result.item1) {
      result.item2.forEach((element) {
        element.onRing = true;
      });
    }
  }

  Hex getOrCreate(Hex hex) {
    var item = map[hex.toHash()];
    if (item == null) {
      addHex(hex);
      item = hex;
      item.output = getRandomResourceForLevel(distanceFromCenter(hex));
    }
    return item;
  }

  Tuple2<bool, List<Hex>> ringClosedAt(int radius) {
    List<Hex> results = List.empty(growable: true);
    var center = Hex(0, 0, 0);
    var cube = center.toCube(center.allNeighbours()[4].scaleTo(radius));
    for (var i = 0; i < 6; i++) {
      for (var j = 0; j < radius; j++) {
        if (!ownsHex(cube)) {
          return Tuple2(false, []);
        }
        results.add(map[cube.toHash()]);
        cube = cube.allNeighbours()[i];
      }
    }
    return Tuple2(true, results);
  }

  void save() async {
    await AppPreferences.instance.saveMap(this.toJson());
  }

  Tuple2<bool, List<Resource>> satisfiesResourceRequirement(
      List<Resource> requirements) {
    List<Resource> results = [];
    if (requirements.isEmpty) {
      return Tuple2(true, []);
    }
    var result = true;
    for (var req in requirements) {
      var existing = stockForResource(req);
      if (existing == null || existing.value < req.value) {
        result = false;
        results.add(req);
      }
    }

    return Tuple2(result, results);
  }

  void addResource(Resource resource) {
    var existing = stockForResource(resource);
    if (existing == null) {
      stock.add(resource);
    } else {
      existing.value += resource.value;
    }
  }

  static MapStorageExpand generate(GAME_MODES mode) {
    var map = MapStorageExpand(gameMode: GameMode.createMode(mode));
    map.map = map.generateCubes(7);
    return map;
  }

  Map<String, Hex> generateCubes(int amount) {
    var counter = 0;
    Map<String, Hex> map = {};
    var start = Hex(0, 0, 0);
    Queue<Hex> queue = Queue.from([start]);

    while (queue.isNotEmpty && counter < amount) {
      Hex next = queue.removeFirst();
      if (map[next.toHash()] != null) {
        continue;
      }
      var neighbours = next.allNeighbours();
      queue.addAll(neighbours);
      map[next.toHash()] = next;
      if (counter != 0) {
        next.output = getRandomResourceForLevel(
          distanceFromCenter(next),
        );
      }
      counter++;
    }

    var first = map[Hex(0, 0, 0).toHash()];
    first.visible = true;
    first.owned = true;
    var neighbours = first.allNeighbours();
    neighbours.forEach((element) {
      map[element.toHash()].visible = true;
    });

    return map;
  }

  Resource getRandomResourceForLevel(int level) {
    var resourceTypes = resourcesForLevel(level);
    var i = Random().nextInt(resourceTypes.length);
    return Resource.fromType(resourceTypes[i]);
  }

  List<RESOURCE_TYPES> resourcesForLevel(int level) {
    var levels = gameMode.resources();
    if (level >= levels.length) {
      level = 4;
    }
    return levels[level];
  }

  Map<String, dynamic> toJson() {
    return {
      "map": map.values.map((hex) => hex.toJson()).toList(),
      "stock": stock.map((e) => e.toJson()).toList(),
      "totalPoints": totalPoints,
      "gameMode": gameMode.toGameModeString(),
    };
  }

  static MapStorageExpand fromJson(Map<String, dynamic> json) {
    List hexJsons = json["map"] as List;
    List stockJson = json["stock"] as List;
    var hexes = hexJsons.map((e) => Hex.fromJson(e));
    var map = MapStorageExpand(
        map: {},
        gameMode: GameMode.createMode(gameModeFromString(json["gameMode"])));
    map.totalPoints = json["totalPoints"] ?? 0;
    hexes.forEach((hex) {
      map.addHex(hex);
    });
    map.stock = stockJson.map((e) => Resource.fromJson(e)).toList();
    return map;
  }

  void shuffle() {
    var allVisible =
        asList().where((element) => element.visible && !isHome(element));
    for (var hex in allVisible) {
      var distance = distanceFromCenter(hex);
      var newHex = hex.clone();
      newHex.output = getRandomResourceForLevel(distance);
      addHex(newHex);
    }
    totalPoints -= 50;
  }
  
  bool isGameOver() {
    var allVisible =
        asList().where((element) => element.visible && !element.owned);

    var isGameOver = true;
    for (var visible in allVisible) {
      if (satisfiesResourceRequirement(visible.toRequirement()).item1) {
        isGameOver = false;
        break;
      }
    }

    return isGameOver;
  }

  void dispose() {
    super.dispose();
  }
}
