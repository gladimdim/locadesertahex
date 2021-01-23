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
      case RESOURCE_TYPES.FIREARM: action = SOUND_TYPE.FIREARM_GATHERED; break;
      case RESOURCE_TYPES.STONE: action = SOUND_TYPE.STONE_GATHERED; break;
      case RESOURCE_TYPES.GRAINS: action = SOUND_TYPE.GRAINS_GATHERED; break;
      case RESOURCE_TYPES.WOOD: action = SOUND_TYPE.WOOD_GATHERED; break;
      case RESOURCE_TYPES.HORSE: action = SOUND_TYPE.HORSE_GATHERED; break;
      case RESOURCE_TYPES.FISH: action = SOUND_TYPE.FISH_GATHERED; break;
      case RESOURCE_TYPES.BOAT: action = SOUND_TYPE.BOAT_GATHERED; break;
      default: break;
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
}
