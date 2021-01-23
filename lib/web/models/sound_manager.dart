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
    SOUND_TYPE.FIREARM_GATHERED: "/hex/assets/assets/sounds/firearm_gathered.mp3",
    SOUND_TYPE.STONE_GATHERED: "/hex/assets/assets/sounds/stone_gathered.mp3",
    SOUND_TYPE.GRAINS_GATHERED: "/hex/assets/assets/sounds/grains_gathered.mp3",
    SOUND_TYPE.WOOD_GATHERED: "/hex/assets/assets/sounds/wood_gathered.mp3",
    SOUND_TYPE.HORSE_GATHERED: "/hex/assets/assets/sounds/horse_gathered.mp3",
    SOUND_TYPE.FISH_GATHERED: "/hex/assets/assets/sounds/fish_gathered.mp3",
    SOUND_TYPE.BOAT_GATHERED: "/hex/assets/assets/sounds/boat_gathered.mp3",
    SOUND_TYPE.PLANKS_GATHERED: "/hex/assets/assets/sounds/planks_gathered.mp3",
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
