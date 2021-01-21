
import 'package:locadesertahex/models/resources/powder.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:locadesertahex/models/resources/wood.dart';

class FireArm extends Resource {
  String localizedKey = 'firearm';
  String localizedDescriptionKey = 'firearmDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.FIREARM;

  FireArm([value]) : super(value);

  List<Resource> toRequirement() {
    return [Wood(value), Powder(value/2)];
  }
}