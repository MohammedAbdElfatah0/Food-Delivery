import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessageService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _requestPermission();
    await _getToken();
    _initListeners();
  }

  Future<void> _requestPermission() async {
    await _firebaseMessaging.requestPermission();
  }

  Future<void> _getToken() async {
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');
  }

  void _initListeners() {
    // Foreground
    FirebaseMessaging.onMessage.listen(handleMessage);

    // Background (when user taps notification)
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Terminated
    _firebaseMessaging.getInitialMessage().then(handleMessage);
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    print('Message data: ${message.data}');
    // navigatorKey.currentState?.pushNamed('/notification');
  }
}
