import 'package:locadesertahex/models/resources/boat/boat.dart';
import 'package:locadesertahex/models/resources/cannon_resource.dart';
import 'package:locadesertahex/models/resources/cart/cart.dart';
import 'package:locadesertahex/models/resources/cossack.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class Tower extends Resource {
  String localizedKey = 'tower';
  String localizedDescriptionKey = 'towerDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.TOWER;
  double defaultValue = 1;
  int points = 40;
  Tower([value]) : super(value) {
    value = value ?? defaultValue;
  }

  List<Resource> toRequirement() {
    return [
      Cannon(value * 10),
      Cossack(value * 40),
      Cart(value * 5),
      Boat(value * 2)
    ];
  }
}
