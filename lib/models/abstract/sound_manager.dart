import 'package:locadesertahex/models/resources/resource_utils.dart';

abstract class SoundManagerClass {
  Map<SOUND_TYPE, String> actionMapping = Map();
  Map<String, int> sounds = {};

  Future initSounds() async {}

  playSound(SOUND_TYPE action) async {}

  playSoundForResourceType(RESOURCE_TYPES type) async {}
}

enum SOUND_TYPE { FIREARM_GATHERED, STONE_GATHERED, GRAINS_GATHERED, WOOD_GATHERED, HORSE_GATHERED }
