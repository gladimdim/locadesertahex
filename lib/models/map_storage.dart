import 'dart:collection';
import 'dart:math';

import 'package:locadesertahex/models/app_preferences.dart';
import 'package:locadesertahex/models/city_hex.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class MapStorage {
  Map<String, Hex> map;
  List<Resource> stock = [];
  List<CityHex> cities = [
    CityHex.generateForDirection(0),
    CityHex.generateForDirection(1),
    CityHex.generateForDirection(2),
    CityHex.generateForDirection(3),
    CityHex.generateForDirection(4),
    CityHex.generateForDirection(5),
  ];
  BehaviorSubject _innerChanges = BehaviorSubject<MapStorage>();
  ValueStream<MapStorage> changes;

  MapStorage({this.map}) {
    changes = _innerChanges.stream;
  }

  bool ownHex(Hex hex) {
    if (!satisfiesResourceRequirement(hex.toRequirement())) {
      return false;
    }
    hex.toRequirement().forEach(removeResource);
    map[hex.toHash()] = hex;
    hex.owned = true;
    hex.visible = true;

    // highlight rings
    processRings(distanceFromCenter(hex));
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
    _innerChanges.add(this);
    return true;
  }

  void processRings(radius) {
    Tuple2<bool, List<Hex>> result = ringClosedAt(radius);
    if (result.item1) {
      result.item2.forEach((element) {
        element.onRing = true;
      });
    }
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

  bool hasHex(Hex hex) {
    return map[hex.toHash()] != null;
  }

  bool ownsHex(Hex hex) {
    return hasHex(hex) && map[hex.toHash()].owned;
  }

  void save() async {
    await AppPreferences.instance.saveMap(this.toJson());
  }

  void putLast(Hex hex) {
    map.removeWhere((key, value) => key == hex.toHash());
    addHex(hex);
  }

  bool satisfiesResourceRequirement(List<Resource> requirements) {
    if (requirements.isEmpty) {
      return true;
    }
    var result = true;
    for (var req in requirements) {
      var existing = stockForResource(req);
      if (existing == null || existing.value < req.value) {
        result = false;
        break;
      }
    }

    return result;
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
    if (satisfiesResourceRequirement([resource])) {
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

  Hex getOrCreate(Hex hex) {
    var item = map[hex.toHash()];
    if (item == null) {
      addHex(hex);
      item = hex;
      item.output =
          MapStorage.getRandomResourceForLevel(distanceFromCenter(hex));
    }
    return item;
  }

  List<Hex> asList() {
    return map.values.toList();
  }

  static MapStorage generate() {
    return MapStorage(map: MapStorage.generateCubes(7));
  }

  static Map<String, Hex> generateCubes(int amount) {
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
        next.output =
            MapStorage.getRandomResourceForLevel(distanceFromCenter(next));
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

  static Resource getRandomResourceForLevel(int level) {
    var resourceTypes = resourcesForLevel(level);
    var i = Random().nextInt(resourceTypes.length);
    return Resource.fromType(resourceTypes[i]);
  }

  static List<List<RESOURCE_TYPES>> resourcesByLevels() {
    var food = [
      RESOURCE_TYPES.GRAINS,
      RESOURCE_TYPES.FOOD,
    ];
    var resources = [
      RESOURCE_TYPES.WOOD,
      RESOURCE_TYPES.STONE,
      RESOURCE_TYPES.FOOD,
      RESOURCE_TYPES.WOOD,
      RESOURCE_TYPES.IRON_ORE,
      RESOURCE_TYPES.WOOD,
      RESOURCE_TYPES.CHARCOAL,
    ];
    var military = [
      RESOURCE_TYPES.FIREARM,
      RESOURCE_TYPES.MONEY,
      RESOURCE_TYPES.POWDER,
    ];
    var moneyMakers = [
      RESOURCE_TYPES.FISH,
      RESOURCE_TYPES.FUR,
    ];
    var higherLevel = [
      RESOURCE_TYPES.MONEY,
      RESOURCE_TYPES.HORSE,
      RESOURCE_TYPES.PLANKS,
      RESOURCE_TYPES.METAL_PARTS,
    ];

    var army = [
      RESOURCE_TYPES.CANNON,
      RESOURCE_TYPES.COSSACK,
    ];

    var highLevelArmy = [
      RESOURCE_TYPES.BOAT,
      RESOURCE_TYPES.CART,
    ];
    return [
      [],
      [RESOURCE_TYPES.GRAINS],
      [...food, ...resources],
      [...food, ...resources],
      [...food, ...moneyMakers, ...military],
      [...moneyMakers, ...resources],
      [...food, ...resources, ...military],
      [...army, ...higherLevel],
      [...army, ...higherLevel, ...military],
      [...military, ...higherLevel],
      [RESOURCE_TYPES.TOWER],
      [...resources, ...moneyMakers, ...food],
      [...resources],
      [...moneyMakers, ...military],
      [RESOURCE_TYPES.TOWER],
      [...army, ...moneyMakers],
      [...resources, ...higherLevel],
      [...moneyMakers, ...higherLevel],
      [...resources, ...higherLevel, ...food],
      [...highLevelArmy, ...higherLevel],
      military,
      resources,
      food,
      higherLevel,
      moneyMakers,
    ];
  }

  static List<RESOURCE_TYPES> resourcesForLevel(int level) {
    var levels = MapStorage.resourcesByLevels();
    if (level >= levels.length) {
      level = 4;
    }
    return levels[level];
  }

  Map<String, dynamic> toJson() {
    return {
      "map": map.values.map((hex) => hex.toJson()).toList(),
      "stock": stock.map((e) => e.toJson()).toList(),
    };
  }

  static MapStorage fromJson(Map<String, dynamic> json) {
    List hexJsons = json["map"] as List;
    List stockJson = json["stock"] as List;
    var hexes = hexJsons.map((e) => Hex.fromJson(e));
    var map = MapStorage(map: {});
    hexes.forEach((hex) {
      map.addHex(hex);
    });
    map.stock = stockJson.map((e) => Resource.fromJson(e)).toList();
    return map;
  }
}

int distanceFromCenter(Hex hex) {
  return ((hex.x.abs() + hex.y.abs() + hex.z.abs()) / 2).floor();
}
