import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingServices {
  static late SharedPreferences sharedPrefers;

  static Future<void> initializeSharedPreferencesStorage() async {
    sharedPrefers = await SharedPreferences.getInstance();
  }

  bool isFirstTime() {
    return sharedPrefers.getBool("isFirstTime") ?? true;
  }

  Future<void> setFirstTimeWithFalse() async {
    await sharedPrefers.setBool("isFirstTime", false);
  }
}
