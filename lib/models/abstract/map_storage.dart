import 'dart:collection';
import 'dart:math';

import 'package:locadesertahex/hexgrid/funcs.dart';
import 'package:locadesertahex/models/app_preferences.dart';
import 'package:locadesertahex/models/city_hex.dart';
import 'package:locadesertahex/models/game_modes.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

enum STORAGE_EVENTS { ADD, SELECTION_CHANGE }

abstract class MapStorage {
  Map<String, Hex> map = {};
  List<Resource> stock = [];
  int totalPoints = 0;
  List<CityHex> cities = [];
  BehaviorSubject _innerChanges = BehaviorSubject<STORAGE_EVENTS>();
  ValueStream<STORAGE_EVENTS> changes;
  Hex selected;
  GameMode gameMode;

  MapStorage({this.map, this.gameMode}) {
    changes = _innerChanges.stream;
  }

  Tuple2<bool, List<Resource>> ownHex(Hex hex) {
    var satisfaction = satisfiesResourceRequirement(hex.toRequirement());
    if (!satisfaction.item1) {
      return satisfaction;
    }
    hex.toRequirement().forEach(removeResource);
    map[hex.toHash()] = hex;
    hex.owned = true;
    hex.visible = true;
    totalPoints += hex.output.points;
    List<Hex> cityHexes = [];
    cities.forEach((cityHex) {
      cityHexes.addAll(cityHex.getCircle());
    });
    hex.allNeighbours().forEach((element) {
      var item = getOrCreate(element);
      // check for city circles
      var foundInCity =
          cityHexes.where((cityHex) => cityHex.equalsTo(item)).toList();

      if (foundInCity.isNotEmpty) {
        addHex(foundInCity[0]);
      }

      item.visible = true;
    });
    addResource(hex.output);
    save();
    _innerChanges.add(STORAGE_EVENTS.ADD);
    return Tuple2(true, null);
  }

  void processRings(radius) {}

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

  void generateRing(int radius, RESOURCE_TYPES type) {
    List<Hex> results = List.empty(growable: true);
    var center = Hex(0, 0, 0);
    var cube = center.toCube(center.allNeighbours()[4].scaleTo(radius));
    for (var i = 0; i < 6; i++) {
      for (var j = 0; j < radius; j++) {
        cube.output = Resource.fromType(type);
        results.add(cube);
        cube = cube.allNeighbours()[i];
      }
    }
    results.forEach((hex) {
      if (!ownsHex(hex)) {
        hex.visible = true;
        addHex(hex);
      }
    });
  }

  bool hasHex(Hex hex) {
    return map[hex.toHash()] != null;
  }

  bool ownsHex(Hex hex) {
    return hasHex(hex) && map[hex.toHash()].owned;
  }

  void save() async {}

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

  Resource stockForResource(Resource resource) {
    try {
      var existing =
          stock.firstWhere((element) => element.type == resource.type);
      return existing;
    } catch (e) {
      return null;
    }
  }

  Resource stockForResourceType(RESOURCE_TYPES type) {
    return stockForResource(Resource.fromType(type));
  }

  void removeResource(Resource resource) {
    if (satisfiesResourceRequirement([resource]).item1) {
      stockForResource(resource).value -= resource.value;
    }
  }

  void addResource(Resource resource) {
    var existing = stockForResource(resource);
    if (existing == null) {
      stock.add(resource);
    } else {
      existing.value += resource.value;
    }
  }

  void addHex(Hex hex) {
    map[hex.toHash()] = hex;
  }

  Hex getOrCreate(Hex hex);

  List<Hex> asList() {
    return map.values.toList();
  }

  Map<String, dynamic> toJson();

  static MapStorage fromJson(Map<String, dynamic> json) {}

  void selectHex(Hex hex) {
    selected = hex;
    _innerChanges.add(STORAGE_EVENTS.SELECTION_CHANGE);
  }

  Hex selectedHex() {
    return selected;
  }

  void clearSelectedHex() {
    selected = null;
    _innerChanges.add(STORAGE_EVENTS.SELECTION_CHANGE);
  }

  void shuffle();

  bool isGameOver();

  void dispose() {
    _innerChanges.close();
  }
}

class MapStorageBuilder extends MapStorage {
  List<Hex> stack = [];
  Map<String, Hex> map;
  GameMode gameMode;

  List<List<RESOURCE_TYPES>> _levels;

  MapStorageBuilder({this.gameMode, this.map}) {
    gameMode = gameMode ?? GameModeClassic();
    var start = Hex(0, 0, 0);
    start.visible = true;
    start.owned = true;
    addHex(start);
    var neighbours = start.allNeighbours();
    neighbours.forEach((element) {
      element.visible = true;
      addHex(element);
    });

    generateRings();
    addCities();

    _levels = [
      [RESOURCE_TYPES.GRAINS],
      gameMode.food,
      gameMode.food,
      gameMode.simpleResources,
      [...gameMode.simpleResources, ...gameMode.food],
      [...gameMode.simpleResources, ...gameMode.food],
      gameMode.higherLevel,
      gameMode.higherLevel,
      gameMode.moneyMakers,
      gameMode.military,
      gameMode.military,
      gameMode.army,
      gameMode.highLevelArmy,
    ];
    generateHandStack();
  }

  addCities() {
    gameMode.cities.forEach((cityHex) {
      var hexes = cityHex.getCircle();
      hexes.forEach((hex) {
        if (!ownsHex(hex)) {
          hex.visible = true;
          addHex(hex);
        }
      });
    });
  }

  void generateRings() {
    generateRing(15, RESOURCE_TYPES.WALL);
    generateRing(20, RESOURCE_TYPES.WALL);
  }

  void generateHandStack() {
    stack = _levels.map((resources) {
      var random = Random().nextInt(resources.length);
      return Hex(0, 0, 0)..output = Resource.fromType(resources[random]);
    }).toList();
  }

  Hex getOrCreate(Hex hex) {
    var item = map[hex.toHash()];
    if (item == null) {
      addHex(hex);
      item = hex;
      item.output = null;
    }
    return item;
  }

  // TODO: FIX THIS
  bool isGameOver() {
    return false;
  }

  void shuffle() {
    throw UnimplementedError();
  }

  static MapStorageBuilder generate(GAME_MODES mode) {
    var map = MapStorageBuilder(map: {}, gameMode: GameMode.createMode(mode));
    return map;
  }

  void consumeHandCard(Hex hex) {
    if (selected == null) {
      return;
    }

    selected.output = hex.output;

    var owned = ownHex(selected);
    if (owned.item1) {
      clearSelectedHex();
      var index = stack.indexOf(hex);
      var level = _levels[index];
      var nextType = _levels[index][Random().nextInt(level.length)];
      var newHex = Hex(0, 0, 0)..output = Resource.fromType(nextType);
      stack[index] = newHex;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "map": map.values.map((hex) => hex.toJson()).toList(),
      "stock": stock.map((e) => e.toJson()).toList(),
      "totalPoints": totalPoints,
      "gameMode": gameMode.toGameModeString(),
      "stack": stack.map((hex) => hex.toJson()).toList(),
    };
  }

  void save() async {
    await AppPreferences.instance.saveBuilderMap(this.toJson());
  }

  static MapStorageBuilder fromJson(Map<String, dynamic> json) {
    List hexJsons = json["map"] as List;
    List stockJson = json["stock"] as List;
    List stackJson = json["stack"] as List;
    var hexes = hexJsons.map((e) => Hex.fromJson(e));
    var storage = MapStorageBuilder(
        map: {},
        gameMode: GameMode.createMode(gameModeFromString(json["gameMode"])));
    storage.totalPoints = json["totalPoints"] ?? 0;
    hexes.forEach((hex) {
      storage.addHex(hex);
    });
    storage.stock = stockJson.map((e) => Resource.fromJson(e)).toList();
    storage.stack = stackJson.map((hexJson) => Hex.fromJson(hexJson)).toList();
    return storage;
  }
}

class MapStorageExpansion extends MapStorage {
  Map<String, Hex> map;
  GameMode gameMode;

  MapStorageExpansion({this.map, this.gameMode}) {
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

  void save() async {
    await AppPreferences.instance.saveExpansionMap(this.toJson());
  }

  void addResource(Resource resource) {
    var existing = stockForResource(resource);
    if (existing == null) {
      stock.add(resource);
    } else {
      existing.value += resource.value;
    }
  }

  static MapStorageExpansion generate(GAME_MODES mode) {
    var map = MapStorageExpansion(gameMode: GameMode.createMode(mode));
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

  static MapStorageExpansion fromJson(Map<String, dynamic> json) {
    List hexJsons = json["map"] as List;
    List stockJson = json["stock"] as List;
    var hexes = hexJsons.map((e) => Hex.fromJson(e));
    var map = MapStorageExpansion(
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
        asList().where((element) => element.visible && !element.isHome());
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
