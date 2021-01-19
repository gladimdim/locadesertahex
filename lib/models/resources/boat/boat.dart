import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class Boat extends Resource {
  String localizedKey = 'boat';
  String localizedDescriptionKey = 'boatDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.BOAT;

  Boat([value]) : super(value);
}
