import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class Cannon extends Resource {
  String localizedKey = 'cannon';
  String localizedDescriptionKey = 'cannonDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.CANNON;

  Cannon([value]) : super(value);
}
