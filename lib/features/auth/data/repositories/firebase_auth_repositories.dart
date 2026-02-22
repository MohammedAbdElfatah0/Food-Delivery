import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/features/auth/domain/repositories/auth_repositories.dart';

class FirebaseAuthRepositories extends AuthRepositories {
  final _auth = FirebaseAuth.instance;

 

  @override
  Future<void> logOut() {
    return _auth.signOut();
  }
}
