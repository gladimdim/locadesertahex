import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class Fur extends Resource {
  String localizedKey = 'fur';
  String localizedDescriptionKey = 'furDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.FUR;

  Fur([value]) : super(value);
}
