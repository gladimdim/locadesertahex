import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences._internal();

  static final AppPreferences instance = AppPreferences._internal();
  late SharedPreferences _preferences;
  String _languageCode = "languageCode";
  String _savedGameExpansion = "saved_game_expansion";
  String _savedGameBuilder = "saved_game_builder";
  String _soundEnabled = "soundEnabled";

  Future init() async {
    try {
      _preferences = await SharedPreferences.getInstance();
      return _preferences;
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future saveMap(Map<String, dynamic> mapJson, String mapKey) async {
    var string = jsonEncode(mapJson);
    try {
      return await _preferences.setString(mapKey, string);
    } catch (e) {
      return null;
    }
  }

  Future saveExpansionMap(Map<String, dynamic> mapJson) {
    return saveMap(mapJson, _savedGameExpansion);
  }

  Future saveBuilderMap(Map<String, dynamic> mapJson) {
    return saveMap(mapJson, _savedGameBuilder);
  }

  Map<String, dynamic>? loadMap(sMapName) {
    try {
      var s = _preferences.getString(sMapName);
      if (s != null) {
        var map = jsonDecode(s);
        return map;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic>? loadExpansionMap() {
    return loadMap(_savedGameExpansion);
  }

  Map<String, dynamic>? loadBuilderMap() {
    return loadMap(_savedGameBuilder);
  }

  String getUILanguage() {
    return _preferences.getString(_languageCode) ?? "uk";
  }

  Future setUILanguage(String languageCode) async {
    return await _preferences.setString(_languageCode, languageCode);
  }

  Future removeUILanguage() async {
    return await _preferences.remove(_languageCode);
  }

  Future setSoundEnabled(bool value) async {
    return await _preferences.setBool(_soundEnabled, value);
  }

  bool getSoundEnabled() {
    return _preferences.getBool(_soundEnabled) ?? true;
  }
}
