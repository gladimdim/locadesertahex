import 'package:locadesertahex/models/resources/cannon_resource.dart';
import 'package:locadesertahex/models/resources/cossack.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';


class Tower extends Resource {
  String localizedKey = 'tower';
  String localizedDescriptionKey = 'towerDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.TOWER;

  Tower([value]) : super(value);

  List<Resource> toRequirement() {
    return [Cannon(value * 3), Cossack(value * 15)];
  }

}
