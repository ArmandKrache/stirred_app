import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_app/router.dart';

class AppData {
  static String? currentUser;

  static void setCurrentUser(String? newUser) {
    currentUser = newUser;
  }

  static Future<void> getCurrentUserFromCache(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("username") && prefs.containsKey("password")) {
      setCurrentUser(prefs.getString("username"));
    } else {
      AppRouter.logout(context);
    }
  }
}