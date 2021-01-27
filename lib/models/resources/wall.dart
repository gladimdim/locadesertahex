
import 'package:locadesertahex/models/resources/cannon_resource.dart';
import 'package:locadesertahex/models/resources/cossack.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';


class Wall extends Resource {
  String localizedKey = 'tower';
  String localizedDescriptionKey = 'towerDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.WALL;
  double defaultValue = 1;
  Wall([value]) : super(value)  {
    value = value ?? defaultValue;
  }
  List<Resource> toRequirement() {
    return [Cannon(value * 5), Cossack(value * 20)];
  }

}
