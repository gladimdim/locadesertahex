import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:locadesertahex/models/resources/wood.dart';

class Planks extends Resource {
  String localizedKey = 'planks';
  String localizedDescriptionKey = 'planksDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.PLANKS;

  Planks([value]) : super(value);

  List<Resource> toRequirement() {
    return [Wood(value / 5)];
  }
}
