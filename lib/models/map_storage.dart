import 'dart:collection';
import 'dart:math';

import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class MapStorage {
  Map<String, Hex> map;
  List<Resource> stock = [];

  MapStorage({this.map});

  bool ownHex(Hex hex) {
    if (!satisfiesResourceRequirement(hex.toRequirement())) {
      return false;
    }
    hex.toRequirement().forEach(removeResource);
    map[hex.toHash()] = hex;
    hex.owned = true;
    hex.visible = true;

    hex.allNeighbours().forEach((element) {
      var item = getOrCreate(element);
      item.visible = true;
    });
    addResource(hex.output);
    return true;
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
    if (satisfiesResourceRequirement(resource.toRequirement())) {
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
    return Resource.fromType(resourceTypes[i], 10);
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
      RESOURCE_TYPES.IRON_ORE,
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
      RESOURCE_TYPES.BOAT,
      RESOURCE_TYPES.CART,
      RESOURCE_TYPES.CANNON,
      RESOURCE_TYPES.COSSACK,
    ];
    return [
      [],
      food,
      [...food, ...resources],
      food,
      [...food, ...resources],
      [...moneyMakers, ...resources],
      [...food, ...food, ...military, ...resources],
      [...food, ...army, ...higherLevel],
      [...army, ...higherLevel, ...food],
      [...food, ...military, ...army],
      [...resources, ...moneyMakers, ...food],
      [...resources, ...food],
      [...moneyMakers, ...food, ...military],
      [...army, ...moneyMakers],
      [...resources, ...higherLevel, ...food],
      [...moneyMakers, ...higherLevel, ...food],
      [...resources, ...higherLevel, ...food],
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
}

int distanceFromCenter(Hex hex) {
  return ((hex.x.abs() + hex.y.abs() + hex.z.abs()) / 2).floor();
}
