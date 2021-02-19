import 'package:locadesertahex/models/city_hex.dart';
import 'package:locadesertahex/models/game_modes.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

enum STORAGE_EVENTS { ADD, SELECTION_CHANGE }

abstract class MapStorage {
  Map<String, Hex> map;
  List<Resource> stock = [];
  int totalPoints = 0;
  List<CityHex> cities;
  BehaviorSubject _innerChanges = BehaviorSubject<STORAGE_EVENTS>();
  ValueStream<STORAGE_EVENTS> changes;
  Hex selected;
  GameMode gameMode;

  MapStorage({this.map, this.gameMode}) {
    changes = _innerChanges.stream;
    gameMode = gameMode ?? GameModeClassic();
    cities = gameMode.cities;
  }

  Tuple2<bool, List<Resource>> ownHex(Hex hex);

  void processRings(radius) {}

  Tuple2<bool, List<Hex>> ringClosedAt(int radius);

  bool hasHex(Hex hex) {
    return map[hex.toHash()] != null;
  }

  bool ownsHex(Hex hex) {
    return hasHex(hex) && map[hex.toHash()].owned;
  }

  void save() async {}

  Tuple2<bool, List<Resource>> satisfiesResourceRequirement(
      List<Resource> requirements);

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


  List<RESOURCE_TYPES> resourcesForLevel(int level);

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
}
