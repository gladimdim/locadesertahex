import 'package:locadesertahex/models/resources/grains.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class Food extends Resource {
  String localizedKey = 'food';
  String localizedDescriptionKey = 'foodDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.FOOD;

  Food([value]) : super(value);

  List<Resource> toRequirement() {
    return [Grains(value / 5)];
  }
}
