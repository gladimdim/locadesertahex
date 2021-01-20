import 'package:locadesertahex/models/resources/boat/boat.dart';
import 'package:locadesertahex/models/resources/cannon_resource.dart';
import 'package:locadesertahex/models/resources/cart/cart.dart';
import 'package:locadesertahex/models/resources/coal/coal.dart';
import 'package:locadesertahex/models/resources/metal_parts/metal_parts.dart';
import 'package:locadesertahex/models/resources/planks/planks.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';

abstract class Resource {
  String localizedKey;
  int value;
  RESOURCE_TYPES type;

  String toImagePath() {
    return "images/resources/$localizedKey.png";
  }

  String toIconPath() {
    return "images/resources/${localizedKey}_128.png";
  }

  Resource([value]);

  static Resource fromType(RESOURCE_TYPES type, [int value]) {
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
    }
    throw "Resource Type $type is not recognized";
  }

  static Resource fromKey(String key, [int value]) {
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
      case 'coal':
        return Charcoal(value);
      case 'metalParts':
        return MetalParts(value);
      case 'cart':
        return Cart(value);
      case 'resource.boat':
        return Boat(value);
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

class Powder extends Resource {
  String localizedKey = 'powder';
  String localizedDescriptionKey = 'powderDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.POWDER;

  Powder([value]) : super(value);
}

class Horse extends Resource {
  String localizedKey = 'horse';
  String localizedDescriptionKey = 'horseDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.HORSE;

  Horse([value]) : super(value);
}

class Money extends Resource {
  String localizedKey = 'money';
  String localizedDescriptionKey = 'moneyDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.MONEY;


  Money([value]) : super(value);
}

class Wood extends Resource {
  String localizedKey = 'wood';
  String localizedDescriptionKey = 'woodDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.WOOD;

  Wood([value]) : super(value);
}

class Stone extends Resource {
  String localizedKey = 'stone';
  String localizedDescriptionKey = 'stoneDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.STONE;

  Stone([value]) : super(value);
}

class FireArm extends Resource {
  String localizedKey = 'firearm';
  String localizedDescriptionKey = 'firearmDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.FIREARM;

  FireArm([value]) : super(value);
}

class Fish extends Resource {
  String localizedKey = 'fish';
  String localizedDescriptionKey = 'fishDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.FISH;

  Fish([value]) : super(value);
}

class Food extends Resource {
  String localizedKey = 'food';
  String localizedDescriptionKey = 'foodDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.FOOD;

  Food([value]) : super(value);
}

class Fur extends Resource {
  String localizedKey = 'fur';
  String localizedDescriptionKey = 'furDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.FUR;

  Fur([value]) : super(value);
}

class IronOre extends Resource {
  String localizedKey = 'ore';
  String localizedDescriptionKey = 'oreDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.IRON_ORE;

  IronOre([value]) : super(value);
}

class Cossack extends Resource {
  String localizedKey = 'cossack';
  String localizedDescriptionKey = 'cossackDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.COSSACK;

  Cossack([value]) : super(value);
}

class Grains extends Resource {
  String localizedKey = 'grains';
  String localizedDescriptionKey = 'grainsDescription';
  RESOURCE_TYPES type = RESOURCE_TYPES.GRAINS;

  Grains([value]) : super(value);
}
