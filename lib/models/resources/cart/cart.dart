import 'package:locadesertahex/models/resources/metal_parts/metal_parts.dart';
import 'package:locadesertahex/models/resources/planks/planks.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:locadesertahex/models/resources/wood.dart';

class Cart extends Resource {
  String localizedKey = 'cart';
  String localizedDescriptionKey = 'cartDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.CART;

  Cart([value]) : super(value);

  List<Resource> toRequirement() {
    return [Wood(value), Planks(value* 3), MetalParts(value * 1.5)];
  }
}
