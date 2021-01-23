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
    SOUND_TYPE action;
    switch (type) {
      case RESOURCE_TYPES.FIREARM: action = SOUND_TYPE.FIREARM_GATHERED; break;
      case RESOURCE_TYPES.STONE: action = SOUND_TYPE.STONE_GATHERED; break;
      case RESOURCE_TYPES.GRAINS: action = SOUND_TYPE.GRAINS_GATHERED; break;
      case RESOURCE_TYPES.WOOD: action = SOUND_TYPE.WOOD_GATHERED; break;
      case RESOURCE_TYPES.HORSE: action = SOUND_TYPE.HORSE_GATHERED; break;
      default: break;
    }

    if (action != null) {
      playSound(action);
    }
  }
  playSound(SOUND_TYPE action) async {
    print("playing web sound");
    playWebAudio(actionMapping[action]);
  }
}
