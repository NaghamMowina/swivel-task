import 'package:shared_preferences/shared_preferences.dart';

class _SessionManager {
  final String userName = 'user-name';

  Future<void> setUsername({String? name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userName, name!);
  }

  Future<String> getUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String name;
    name = pref.getString(userName) ?? '';
    return name;
  }
}

final sessionManager = _SessionManager();
