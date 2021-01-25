import 'package:locadesertahex/models/resources/grains.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class Horse extends Resource {
  String localizedKey = 'horse';
  String localizedDescriptionKey = 'horseDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.HORSE;

  Horse([value]) : super(value);

  List<Resource> toRequirement() {
    return [Grains(value / 2)];
  }
}
