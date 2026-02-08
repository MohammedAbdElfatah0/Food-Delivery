import 'dart:math';

class OTPGenerator {
  static String generateOTP({int length = 4}) {
    const chars = '0123456789';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }
}
