import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences._internal();

  static final AppPreferences instance = AppPreferences._internal();
  SharedPreferences _preferences;


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
      return await _preferences.setString("saved_game", string);
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> loadMap() {
      try {
        var s = _preferences.getString("saved_game");
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
    return await _preferences.remove("saved_game");
  }
}