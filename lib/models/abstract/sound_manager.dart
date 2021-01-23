import 'package:locadesertahex/loaders/sound_manager.dart';

abstract class SoundManagerClass {
  Map<SOUND_TYPE, String> actionMapping = Map();
  Map<String, int> sounds = {};
  Future initSounds() async {}

  playSound(SOUND_TYPE action) async {}
}
