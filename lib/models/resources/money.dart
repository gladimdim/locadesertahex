import 'package:locadesertahex/models/resources/fish.dart';
import 'package:locadesertahex/models/resources/fur.dart';
import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class Money extends Resource {
  String localizedKey = 'money';
  String localizedDescriptionKey = 'moneyDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.MONEY;

  Money([value]) : super(value);


  List<Resource> toRequirement() {
    return [Fur(value/4), Fish(value / 4)];
  }
}
