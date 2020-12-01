import 'package:shared_preferences/shared_preferences.dart';

///
// * MissingPluginException(No implementation found for method getAll on channel flutter: plugins.flutter.io/shared_preferences)
// * >>> https://github.com/renefloor/flutter_cached_network_image/issues/50
// *
// * cách fix:
//    Run Flutter clean (or remove your build manually)
//    if u are on IOS run pod install
//    and then => Flutter run
// *///
class SPref {
  static final SPref instance = SPref._internal();
  SPref._internal();

  Future set(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  Future<bool> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
