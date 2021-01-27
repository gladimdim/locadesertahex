import 'package:locadesertahex/models/resources/boat/boat.dart';
import 'package:locadesertahex/models/resources/cannon_resource.dart';
import 'package:locadesertahex/models/resources/cart/cart.dart';
import 'package:locadesertahex/models/resources/coal/coal.dart';
import 'package:locadesertahex/models/resources/cossack.dart';
import 'package:locadesertahex/models/resources/firearm.dart';
import 'package:locadesertahex/models/resources/fish.dart';
import 'package:locadesertahex/models/resources/food.dart';
import 'package:locadesertahex/models/resources/fur.dart';
import 'package:locadesertahex/models/resources/grains.dart';
import 'package:locadesertahex/models/resources/horse.dart';
import 'package:locadesertahex/models/resources/iron_ore.dart';
import 'package:locadesertahex/models/resources/metal_parts/metal_parts.dart';
import 'package:locadesertahex/models/resources/money.dart';
import 'package:locadesertahex/models/resources/planks/planks.dart';
import 'package:locadesertahex/models/resources/powder.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:locadesertahex/models/resources/stone.dart';
import 'package:locadesertahex/models/resources/tower.dart';
import 'package:locadesertahex/models/resources/wall.dart';
import 'package:locadesertahex/models/resources/wood.dart';

abstract class Resource {
  String localizedKey;
  double value;
  double defaultValue = 10;
  RESOURCE_TYPES type;
  int points = 1;

  String toImagePath() {
    return "images/resources/$localizedKey.png";
  }

  String toIconPath() {
    return "images/resources/${localizedKey}_128.png";
  }

  Resource([this.value])  {
    value = value ?? defaultValue;
  }

  List<Resource> toRequirement() {
    return [];
  }

  static Resource fromType(RESOURCE_TYPES type, [double value]) {
    switch (type) {
      case RESOURCE_TYPES.FIREARM:
        return FireArm(value);
      case RESOURCE_TYPES.FISH:
        return Fish(value);
      case RESOURCE_TYPES.FOOD:
        return Food(value);
      case RESOURCE_TYPES.FUR:
        return Fur(value);
      case RESOURCE_TYPES.IRON_ORE:
        return IronOre(value);
      case RESOURCE_TYPES.STONE:
        return Stone(value);
      case RESOURCE_TYPES.WOOD:
        return Wood(value);
      case RESOURCE_TYPES.MONEY:
        return Money(value);
      case RESOURCE_TYPES.HORSE:
        return Horse(value);
      case RESOURCE_TYPES.POWDER:
        return Powder(value);
      case RESOURCE_TYPES.COSSACK:
        return Cossack(value);
      case RESOURCE_TYPES.CANNON:
        return Cannon(value);
      case RESOURCE_TYPES.GRAINS:
        return Grains(value);
      case RESOURCE_TYPES.PLANKS:
        return Planks(value);
      case RESOURCE_TYPES.CHARCOAL:
        return Charcoal(value);
      case RESOURCE_TYPES.METAL_PARTS:
        return MetalParts(value);
      case RESOURCE_TYPES.CART:
        return Cart(value);
      case RESOURCE_TYPES.BOAT:
        return Boat(value);
      case RESOURCE_TYPES.TOWER:
        return Tower(value);
      case RESOURCE_TYPES.WALL:
        return Wall(value);
    }
    throw "Resource Type $type is not recognized";
  }

  static Resource fromKey(String key, [double value]) {
    switch (key) {
      case 'firearm':
        return FireArm(value);
      case 'fish':
        return Fish(value);
      case 'food':
        return Food(value);
      case 'fur':
        return Fur(value);
      case 'ore':
        return IronOre(value);
      case 'stone':
        return Stone(value);
      case 'wood':
        return Wood(value);
      case 'money':
        return Money(value);
      case 'horse':
        return Horse(value);
      case 'powder':
        return Powder(value);
      case 'cannon':
        return Cannon(value);
      case 'cossack':
        return Cossack(value);
      case 'grains':
        return Grains(value);
      case 'planks':
        return Planks(value);
      case 'charcoal':
        return Charcoal(value);
      case 'metalParts':
        return MetalParts(value);
      case 'cart':
        return Cart(value);
      case 'boat':
        return Boat(value);
      case 'tower':
        return Tower(value);
      case 'wall':
        return Wall(value);
    }

    throw "Resource localized Key $key was not recognized";
  }

  Map<String, dynamic> toJson() {
    return {
      "type": localizedKey,
      "value": value,
    };
  }

  static Resource fromJson(Map<String, dynamic> json) {
    var type = Resource.fromKey(json["type"]);
    type.value = json["value"];
    return type;
  }
}
