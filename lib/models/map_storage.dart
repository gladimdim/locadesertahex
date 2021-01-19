import 'dart:collection';
import 'dart:math';

import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class MapStorage {
  Map<String, Hex> map;

  MapStorage({this.map});

  void ownHex(Hex hex) {
    map[hex.toHash()] = hex;
    hex.owned = true;
    hex.visible = true;
    hex.allNeighbours().forEach((element) {
      var item = getOrCreate(element);
      item.visible = true;
    });
  }

  void addHex(Hex hex) {
    map[hex.toHash()] = hex;
  }

  Hex getOrCreate(Hex hex) {
    var item = map[hex.toHash()];
    if (item == null) {
      addHex(hex);
      item = hex;
      item.attachment = MapStorage.getRandomResource();
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
      next.attachment = MapStorage.getRandomResource();
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

  static Resource getRandomResource() {
    var resourceTypes = RESOURCE_TYPES.values;
    var i = Random().nextInt(resourceTypes.length);
    return Resource.fromType(resourceTypes[i], 10);
  }
}
