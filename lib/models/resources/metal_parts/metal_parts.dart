import 'package:locadesertahex/models/resources/coal/coal.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class MetalParts extends Resource {
  String localizedKey = 'metalParts';
  String localizedDescriptionKey = 'metalPartslDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.METAL_PARTS;

  MetalParts([value]) : super(value);

  List<Resource> toRequirement() {
    return [IronOre(value), Charcoal(value)];
  }
}
