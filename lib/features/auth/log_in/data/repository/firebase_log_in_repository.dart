import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/features/auth/log_in/domain/entities/log_in_entity.dart';
import 'package:food_delivery/features/auth/log_in/domain/repository/log_in_repository.dart';

class FirebaseLogInRepository extends LogInRepository {
  @override
  Future<LogInEntity> signIn(String email, String password)async {
  try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user == null) {
        throw Exception('User not found');
      }
      await user.reload();
      return LogInEntity(id: user.uid, name: user.displayName!, email: email);
    } on FirebaseAuthException catch (e) {
      //todo ::
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No user found with this email.');
        case 'wrong-password':
          throw Exception('Incorrect password. Please try again.');
        case 'invalid-email':
          throw Exception('Invalid email format.');
        default:
          throw Exception('Sign-in failed: ${e.message}');
      }
    }
  }
    
}