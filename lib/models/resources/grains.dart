import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class Grains extends Resource {
  String localizedKey = 'grains';
  String localizedDescriptionKey = 'grainsDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.GRAINS;

  Grains([value]) : super(value);
}
