import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/features/auth/domain/entities/user_entity.dart';
import 'package:food_delivery/features/auth/domain/repositories/auth_repositories.dart';

class FirebaseAuthRepositories extends AuthRepositories {
  final _auth = FirebaseAuth.instance;

  @override
  Future<UserEntity?> getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      return Future.value(
        UserEntity(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        ),
      );
    }
    return Future.value(null);
  }

  @override
  Future<void> logOut() {
    return _auth.signOut();
  }
}
