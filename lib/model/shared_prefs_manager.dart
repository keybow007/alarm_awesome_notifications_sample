import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {

  String keyNotificationId = "notification_id";

  Future<int> getMaxNotificationId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyNotificationId) ?? 0;
  }

  Future<void> setMaxNotificationId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyNotificationId, id);
  }

}