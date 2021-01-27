import 'package:locadesertahex/models/resources/resource_utils.dart';

abstract class SoundManagerClass {
  Map<SOUND_TYPE, String> actionMapping = Map();
  Map<String, int> sounds = {};

  Future initSounds() async {}

  playSound(SOUND_TYPE action) async {}

  playSoundForResourceType(RESOURCE_TYPES type) async {}

  SOUND_TYPE resourceTypeToSoundType(RESOURCE_TYPES resType) {
    SOUND_TYPE action;
    switch (resType) {
      case RESOURCE_TYPES.FIREARM:
        action = SOUND_TYPE.FIREARM_GATHERED;
        break;
      case RESOURCE_TYPES.STONE:
        action = SOUND_TYPE.STONE_GATHERED;
        break;
      case RESOURCE_TYPES.GRAINS:
        action = SOUND_TYPE.GRAINS_GATHERED;
        break;
      case RESOURCE_TYPES.WOOD:
        action = SOUND_TYPE.WOOD_GATHERED;
        break;
      case RESOURCE_TYPES.HORSE:
        action = SOUND_TYPE.HORSE_GATHERED;
        break;
      case RESOURCE_TYPES.FISH:
        action = SOUND_TYPE.FISH_GATHERED;
        break;
      case RESOURCE_TYPES.BOAT:
        action = SOUND_TYPE.BOAT_GATHERED;
        break;
      case RESOURCE_TYPES.PLANKS:
        action = SOUND_TYPE.PLANKS_GATHERED;
        break;
      case RESOURCE_TYPES.MONEY:
        action = SOUND_TYPE.MONEY_GATHERED;
        break;
      case RESOURCE_TYPES.CANNON:
        action = SOUND_TYPE.CANNON_GATHERED;
        break;
      case RESOURCE_TYPES.FOOD:
        action = SOUND_TYPE.FOOD_GATHERED;
        break;
      case RESOURCE_TYPES.COSSACK:
        action = SOUND_TYPE.COSSACK_GATHERED;
        break;
      case RESOURCE_TYPES.CART:
        action = SOUND_TYPE.CART_GATHERED;
        break;
      case RESOURCE_TYPES.IRON_ORE:
        action = SOUND_TYPE.ORE_GATHERED;
        break;
      case RESOURCE_TYPES.CHARCOAL:
        action = SOUND_TYPE.COAL_GATHERED;
        break;
      case RESOURCE_TYPES.FUR:
        action = SOUND_TYPE.FUR_GATHERED;
        break;
      case RESOURCE_TYPES.METAL_PARTS:
        action = SOUND_TYPE.METAL_PARTS_GATHERED;
        break;
      case RESOURCE_TYPES.POWDER:
        action = SOUND_TYPE.POWDER_GATHERED;
        break;
      case RESOURCE_TYPES.TOWER:
        action = SOUND_TYPE.CANNON_GATHERED;
        break;
      case RESOURCE_TYPES.WALL:
        action = SOUND_TYPE.CANNON_GATHERED;
        break;
    }
    return action;
  }
}

enum SOUND_TYPE {
  FIREARM_GATHERED,
  STONE_GATHERED,
  GRAINS_GATHERED,
  WOOD_GATHERED,
  HORSE_GATHERED,
  FISH_GATHERED,
  BOAT_GATHERED,
  PLANKS_GATHERED,
  MONEY_GATHERED,
  CANNON_GATHERED,
  FOOD_GATHERED,
  COSSACK_GATHERED,
  CART_GATHERED,
  ORE_GATHERED,
  COAL_GATHERED,
  FUR_GATHERED,
  METAL_PARTS_GATHERED,
  POWDER_GATHERED,
}
