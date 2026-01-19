import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/core/shared/shared_preference_key.dart';
import 'package:food_delivery/firebase_options.dart';
import 'package:food_delivery/my_app.dart';

import 'core/di/servier_locator.dart';
import 'core/shared/shared_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppPreferences.instance.init();
  await setupServiceLocator();
  final seenOnBoarding = AppPreferences.instance.getBool(key: SharedPreferenceKey.seenOnBoarding);
  String start;
  if (!seenOnBoarding) {
    start = ContentsRouter.onBoarding;
  } else {
    start = ContentsRouter.auth;
  }
  runApp(MyApp(start: start));
}
