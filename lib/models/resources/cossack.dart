import 'package:locadesertahex/models/resources/firearm.dart';
import 'package:locadesertahex/models/resources/food.dart';
import 'package:locadesertahex/models/resources/horse.dart';
import 'package:locadesertahex/models/resources/money.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class Cossack extends Resource {
  String localizedKey = 'cossack';
  String localizedDescriptionKey = 'cossackDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.COSSACK;

  Cossack([value]) : super(value);

  List<Resource> toRequirement() {
    return [FireArm(value), Food(value), Horse(value), Money(value / 2)];
  }
}
