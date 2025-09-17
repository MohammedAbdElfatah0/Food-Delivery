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
  Future<UserEntity> register(String name, String email, String password) async {
  try {
    UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = cred.user;
    if (user != null) {
      // تحديث الـ name
      await user.updateDisplayName(name);
      // Reload عشان الـ Stream يلتقط التغييرات
      await user.reload();
    }
    return UserEntity(id: user!.uid , name: name, email: email);
  } catch (e) {
    rethrow;
  }
}

  @override
  Future<UserEntity?> signIn(String email, String password) async {
    final UserCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = UserCredential.user;
    if (user != null) {
      return UserEntity(
        id: user.uid,
        name: user.displayName!,
        email: user.email!,
      );
      
    }
    throw Exception("user is not found");
  }

  @override
  Future<void> logOut() {
    return _auth.signOut();
  }

  @override
  Stream<User?> isLogIn() {
    return _auth.authStateChanges();
  }
}
