import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class Charcoal extends Resource {
  String localizedKey = 'charcoal';
  String localizedDescriptionKey = 'charcoalDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.CHARCOAL;

  Charcoal([value]) : super(value);

  List<Resource> toRequirement() {
    return [Wood(value / 5)];
  }
}
