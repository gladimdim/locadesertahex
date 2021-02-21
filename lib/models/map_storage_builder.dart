import 'package:locadesertahex/models/abstract/map_storage.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:tuple/tuple.dart';

class MapStorageBuilder extends MapStorage {
  MapStorageBuilder() : super() {
    map = {};
    var start = Hex(0, 0, 0);
    start.visible = true;
    start.owned = true;
    addHex(start);
    var neighbours = start.allNeighbours();
    neighbours.forEach((element) {
      element.visible = true;
      addHex(element);
    });
  }

  Hex getOrCreate(Hex hex) {
    var item = map[hex.toHash()];
    return item;
  }

  @override
  Tuple2<bool, List<Resource>> ownHex(Hex hex) {
    // TODO: implement ownHex
    throw UnimplementedError();
  }

  @override
  List<RESOURCE_TYPES> resourcesForLevel(int level) {
    // TODO: implement resourcesForLevel
    throw UnimplementedError();
  }

  @override
  Tuple2<bool, List<Hex>> ringClosedAt(int radius) {
    // TODO: implement ringClosedAt
    throw UnimplementedError();
  }

  @override
  Tuple2<bool, List<Resource>> satisfiesResourceRequirement(
      List<Resource> requirements) {
    // TODO: implement satisfiesResourceRequirement
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  // TODO: FIX THIS
  bool isGameOver() {
    return false;
  }

  void shuffle() {
    throw UnimplementedError();
  }

  static MapStorageBuilder generate() {
    var map = MapStorageBuilder();
    return map;
  }
}
