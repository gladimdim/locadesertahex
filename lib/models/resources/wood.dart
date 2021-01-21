
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class Wood extends Resource {
  String localizedKey = 'wood';
  String localizedDescriptionKey = 'woodDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.WOOD;

  Wood([value]) : super(value);
}