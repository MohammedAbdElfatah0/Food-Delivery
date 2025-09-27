import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/firebase_options.dart';
import 'package:food_delivery/my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final sharedPref = await SharedPreferences.getInstance();
  final seenOnBoarding = sharedPref.getBool("seenOnBoarding") ?? false;
  String start;
  if (!seenOnBoarding) {
    start = ContentsRouter.onBoarding;
  } else {
    start = ContentsRouter.auth;
  }
  runApp(MyApp(start: start));
}
