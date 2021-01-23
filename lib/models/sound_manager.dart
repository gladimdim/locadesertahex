import 'package:flutter/services.dart';
import 'package:locadesertahex/models/abstract/sound_manager.dart';
import 'package:soundpool/soundpool.dart';

class SoundManager extends SoundManagerClass {
  // contains ids of loaded sounds
  Map<String, int> sounds = {};
  Map<SOUND_TYPE, String> actionMapping = {
    SOUND_TYPE.FIREARM_GATHERED: "assets/sounds/firearm_gathered.mp3",
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

  playSound(SOUND_TYPE action) async {
    await pool.play(sounds[actionMapping[action]]);
  }
}

enum SOUND_TYPE { FIREARM_GATHERED }