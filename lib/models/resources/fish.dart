import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class Fish extends Resource {
  String localizedKey = 'fish';
  String localizedDescriptionKey = 'fishDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.FISH;

  Fish([value]) : super(value);
}