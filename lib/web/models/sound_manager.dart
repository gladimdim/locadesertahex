import 'dart:js' as js;

import 'package:flutter/services.dart';
import 'package:locadesertahex/models/abstract/sound_manager.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:soundpool/soundpool.dart';

void playWebAudio(String path) {
  js.context.callMethod('playAudio', ["assets/$path"]);
}

class SoundManager extends SoundManagerClass {
  // contains ids of loaded sounds
  Map<String, int> sounds = {};

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
    playWebAudio(actionMapping[action]!);
  }
}
