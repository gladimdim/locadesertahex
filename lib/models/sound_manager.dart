import 'package:flutter/services.dart';
import 'package:locadesertahex/models/abstract/sound_manager.dart';
import 'package:locadesertahex/models/app_preferences.dart';
import 'package:locadesertahex/models/resources/resource_utils.dart';
import 'package:soundpool/soundpool.dart';
import 'package:locadesertahex/utils/platform/platform_loader.dart';

class SoundManager extends SoundManagerClass {
  // contains ids of loaded sounds
  Map<String, int> sounds = {};

  SoundManager._internal();

  Future initSounds() async {
    if (UniversalPlatform.windows || UniversalPlatform.linux) {
      return;
    } else {
      pool = Soundpool.fromOptions(
          options: SoundpoolOptions(streamType: StreamType.music));
    }
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

  Soundpool pool;
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
      if (pool != null) {
        await pool.play(sounds[actionMapping[action]]);
      }
    }
  }
}
