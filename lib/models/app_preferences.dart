import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences._internal();

  static final AppPreferences instance = AppPreferences._internal();
  SharedPreferences _preferences;
  String _languageCode = "languageCode";
  String _savedGame = "saved_game";

  Future init() async {
    try {
      _preferences = await SharedPreferences.getInstance();
      return _preferences;
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future saveMap(Map<String, dynamic> mapJson) async {
    var string = jsonEncode(mapJson);
    try {
      return await _preferences.setString(_savedGame, string);
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> loadMap() {
    try {
      var s = _preferences.getString(_savedGame);
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

  Future<bool> removeMap() async {
    return await _preferences.remove(_savedGame);
  }

  String getUILanguage() {
    return _preferences.getString(_languageCode);
  }

  Future setUILanguage(String languageCode) async {
    return await _preferences.setString(_languageCode, languageCode);
  }

  Future removeUILanguage() async {
    return await _preferences.remove(_languageCode);
  }
}
