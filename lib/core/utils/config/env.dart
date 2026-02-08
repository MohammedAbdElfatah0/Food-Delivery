import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Env {
  static String email = dotenv.env['EMAIL']!;
  static String password = dotenv.env['PASSWORD']!;
}
