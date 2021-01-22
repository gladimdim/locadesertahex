import 'package:locadesertahex/models/resources/metal_parts/metal_parts.dart';
import 'package:locadesertahex/models/resources/money.dart';
import 'package:locadesertahex/models/resources/powder.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:locadesertahex/models/resources/wood.dart';

class Cannon extends Resource {
  String localizedKey = 'cannon';
  String localizedDescriptionKey = 'cannonDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.CANNON;

  Cannon([value]) : super(value);

  List<Resource> toRequirement() {
    return [Wood(value), Powder(value/2), MetalParts(3.0), Money(5.0)];
  }
}
