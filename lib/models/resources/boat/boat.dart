import 'package:locadesertahex/models/resources/planks/planks.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class Boat extends Resource {
  String localizedKey = 'boat';
  String localizedDescriptionKey = 'boatDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.BOAT;

  Boat([value]) : super(value);

  List<Resource> toRequirement() {
    return [Planks(value * 2), Wood(value * 4)];
  }

}
