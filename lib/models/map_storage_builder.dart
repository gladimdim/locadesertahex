import 'package:locadesertahex/models/abstract/map_storage.dart';
import 'package:locadesertahex/models/hex.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:tuple/tuple.dart';

class MapStorageBuilder extends MapStorage {
  @override
  Hex getOrCreate(Hex hex) {
    // TODO: implement getOrCreate
    throw UnimplementedError();
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
  Tuple2<bool, List<Resource>> satisfiesResourceRequirement(List<Resource> requirements) {
    // TODO: implement satisfiesResourceRequirement
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
  
}