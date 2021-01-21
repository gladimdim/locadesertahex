import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class IronOre extends Resource {
  String localizedKey = 'ore';
  String localizedDescriptionKey = 'oreDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.IRON_ORE;

  IronOre([value]) : super(value);
}