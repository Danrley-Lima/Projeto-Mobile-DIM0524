import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  static const String _key = 'key';

  static save(String user) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString(
      _key,
      jsonEncode({
        "user": user,
        "isAuth": true,
      }),
    );
  }

  static Future<bool> isAuth() async {
    var prefs = await SharedPreferences.getInstance();
    var jsonResult = prefs.getString(_key);

    if (jsonResult != null) {
      var mapUser = jsonDecode(jsonResult);

      return mapUser['isAuth'];
    }
    return false;
  }

  static Future<String?> getUserId() async {
    var prefs = await SharedPreferences.getInstance();
    var jsonResult = prefs.getString(_key);

    if (jsonResult != null) {
      var mapUser = jsonDecode(jsonResult);

      return mapUser['user'];
    }
    return null;
  }

  static logout() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
