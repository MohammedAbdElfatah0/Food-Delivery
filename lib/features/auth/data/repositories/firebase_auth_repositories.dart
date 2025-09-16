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
  Future<UserEntity?> register(
    String name,
    String email,
    String password,
  ) async {
    return _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userCredential) async{
          final user = userCredential.user;
          if (user != null) {
            await user.updateDisplayName(name);
             await user.reload();
            return UserEntity(
              id: user.uid,
              name: name ,
              email: user.email ?? '',
            );
          }
          return null;
        })
        .catchError((error) {
          // Handle errors here
          print('Error during registration: $error');
          return null;
        });
    
  }

  @override
  Future<UserEntity?> signIn(String email, String password) {
    return _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((userCredential) {
          final user = userCredential.user;
          if (user != null) {
            return UserEntity(
              id: user.uid,
              name: user.displayName ?? '',
              email: user.email ?? '',
            );
          }
          return null;
        })
        .catchError((error) {
          // Handle errors here
          print('Error during sign-in: $error');
          return null;
        });
  }

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }
}
