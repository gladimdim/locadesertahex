import 'package:flutter/services.dart';
import 'package:locadesertahex/models/abstract/sound_manager.dart';
import 'package:locadesertahex/models/app_preferences.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:soundpool/soundpool.dart';

class SoundManager extends SoundManagerClass {
  // contains ids of loaded sounds
  Map<String, int> sounds = {};

  SoundManager._internal();

  Future initSounds() async {
    pool = Soundpool(streamType: StreamType.music);
    if (sounds.isNotEmpty) {
      return;
    }
    await Future.forEach(actionMapping.keys, ((element) async {
      String path = actionMapping[element]!;
      ByteData soundData = await rootBundle.load(path);
      int soundId;
      soundId = await pool.load(soundData);
      sounds[path] = soundId;
    }));
  }

  late Soundpool pool;
  static final SoundManager instance = SoundManager._internal();

  playSoundForResourceType(RESOURCE_TYPES type) async {
    var soundOn = AppPreferences.instance.getSoundEnabled();
    if (!soundOn) {
      return;
    }
    var action = resourceTypeToSoundType(type);

    if (action != null) {
      playSound(action);
    }
  }

  playSound(SOUND_TYPE action) async {
    var soundOn = AppPreferences.instance.getSoundEnabled();
    if (soundOn) {
      await pool.play(sounds[actionMapping[action]]!);
    }
  }
}
