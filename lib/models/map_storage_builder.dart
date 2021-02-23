import 'dart:math';

import 'package:locadesertahex/models/abstract/map_storage.dart';
import 'package:locadesertahex/models/game_modes.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:tuple/tuple.dart';

class MapStorageBuilder extends MapStorage {
  List<Hex> handStack = [];
  Map<String, Hex> map;
  GameMode gameMode;
  Hex selectedHandCard;

  MapStorageBuilder({this.gameMode}) : super() {
    map = {};
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

    generateHandStack();
  }

  void generateHandStack() {
    List<List<RESOURCE_TYPES>> list = [
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

    handStack = list.map((resources) {
      var random = Random().nextInt(resources.length);
      return Hex(0, 0, 0)..output = Resource.fromType(resources[random]);
    }).toList();
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
