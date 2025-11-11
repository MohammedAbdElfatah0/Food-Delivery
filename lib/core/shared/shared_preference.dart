// lib/core/utils/app_preferences.dart

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  // Singleton عشان ما يتعملش غير مرة واحدة في حياة التطبيق
  AppPreferences._();
  static final AppPreferences instance = AppPreferences._();

  late SharedPreferences _prefs;

  // اول مرة تشتغل → تحمل الـ prefs
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ============ Selected City ============
  String get selectedCity => _prefs.getString('selected_city') ?? 'القاهرة';

  Future<void> setSelectedCity(String city) async {
    await _prefs.setString('selected_city', city);
  }

  //=========== onboarding
  bool get seenOnBoarding => _prefs.getBool('seen_on_boarding') ?? false;
  Future<void> setSeenOnBoarding(bool value) async {
    await _prefs.setBool('seen_on_boarding', value);
  }
}
