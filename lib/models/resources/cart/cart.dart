import 'package:locadesertahex/models/resources/resource.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

class Cart extends Resource {
  String localizedKey = 'cart';
  String localizedDescriptionKey = 'cartDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.CART;

  Cart([value]) : super(value);
}
