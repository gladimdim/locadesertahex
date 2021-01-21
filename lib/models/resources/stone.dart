
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class Stone extends Resource {
  String localizedKey = 'stone';
  String localizedDescriptionKey = 'stoneDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.STONE;

  Stone([value]) : super(value);
}