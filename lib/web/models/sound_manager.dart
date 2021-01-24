import 'dart:js' as js;

import 'package:flutter/services.dart';
import 'package:locadesertahex/models/abstract/sound_manager.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:soundpool/soundpool.dart';

void playWebAudio(String path) {
  js.context.callMethod('playAudio', [path]);
}

class SoundManager extends SoundManagerClass {
  // contains ids of loaded sounds
  Map<String, int> sounds = {};
  Map<SOUND_TYPE, String> actionMapping = {
    SOUND_TYPE.FIREARM_GATHERED: "assets/sounds/firearm_gathered.mp3",
    SOUND_TYPE.STONE_GATHERED: "assets/sounds/stone_gathered.mp3",
    SOUND_TYPE.GRAINS_GATHERED: "assets/sounds/grains_gathered.mp3",
    SOUND_TYPE.WOOD_GATHERED: "assets/sounds/wood_gathered.mp3",
    SOUND_TYPE.HORSE_GATHERED: "assets/sounds/horse_gathered.mp3",
    SOUND_TYPE.FISH_GATHERED: "assets/sounds/fish_gathered.mp3",
    SOUND_TYPE.BOAT_GATHERED: "assets/sounds/boat_gathered.mp3",
    SOUND_TYPE.PLANKS_GATHERED: "assets/sounds/planks_gathered.mp3",
    SOUND_TYPE.MONEY_GATHERED: "assets/sounds/money_gathered.mp3",
    SOUND_TYPE.CANNON_GATHERED: "assets/sounds/cannon_gathered.mp3",
    SOUND_TYPE.FOOD_GATHERED: "assets/sounds/food_gathered.mp3",
    SOUND_TYPE.COSSACK_GATHERED: "assets/sounds/cossack_gathered.mp3",
    SOUND_TYPE.CART_GATHERED: "assets/sounds/cart_gathered.mp3",
    SOUND_TYPE.ORE_GATHERED: "assets/sounds/mining.mp3",
    SOUND_TYPE.COAL_GATHERED: "assets/sounds/mining.mp3",
    SOUND_TYPE.FUR_GATHERED: "assets/sounds/fur_gathered.mp3",
    SOUND_TYPE.METAL_PARTS_GATHERED: "assets/sounds/metal_parts_gathered.mp3",
    SOUND_TYPE.POWDER_GATHERED: "assets/sounds/powder_gathered.mp3",
  };
  SoundManager._internal();

  Future initSounds() async {
    if (sounds.isNotEmpty) {
      return;
    }
    await Future.forEach(actionMapping.keys, ((element) async {
      String path = actionMapping[element];
      ByteData soundData = await rootBundle.load(path);
      int soundId;
      soundId = await pool.load(soundData);
      sounds[path] = soundId;
    }));
  }

  Soundpool pool = Soundpool(streamType: StreamType.music);
  static final SoundManager instance = SoundManager._internal();


  playSoundForResourceType(RESOURCE_TYPES type) async {
    var action = resourceTypeToSoundType(type);
    if (action != null) {
      playSound(action);
    }
  }
  playSound(SOUND_TYPE action) async {
    print("playing web sound");
    playWebAudio(actionMapping[action]);
  }
}
