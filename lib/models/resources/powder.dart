import 'package:locadesertahex/models/resources/food.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class Powder extends Resource {
  String localizedKey = 'powder';
  String localizedDescriptionKey = 'powderDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.POWDER;

  Powder([value]) : super(value);

  List<Resource> toRequirement() {
    return [Food(value/2)];
  }
}
