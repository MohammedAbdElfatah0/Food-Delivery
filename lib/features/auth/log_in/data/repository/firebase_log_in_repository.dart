import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/core/utils/error/failures.dart';
import 'package:food_delivery/features/auth/log_in/domain/entities/log_in_entity.dart';
import 'package:food_delivery/features/auth/log_in/domain/repository/log_in_repository.dart';

class FirebaseLogInRepository extends LogInRepository {
  @override
  Future<Either<Failure, LogInEntity>> logIn(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;
      if (user == null) {
        return Left(ServerFailure('User not found after sign-in.'));
      }
      await user.reload();
      return Right(
        LogInEntity(
          id: user.uid,
          name: user.displayName ?? user.email?.split('@').first ?? 'User',
          email: user.email ?? email,
        ),
      );
    } on FirebaseAuthException catch (e, s) {
      log('FirebaseAuthException code: ${e.code}');
      log('FirebaseAuthException message: ${e.message}');
      log('FirebaseAuthException credential: ${e.email}');
      log('StackTrace: $s');
      switch (e.code) {
        case 'user-not-found':
          return Left(FirebaseFailure('No user found with this email.'));
        case 'wrong-password':
          return Left(FirebaseFailure('Incorrect password. Please try again.'));
        case 'invalid-email':
          return Left(FirebaseFailure('The email address is badly formatted.'));
        case 'invalid-credential':
          // This usually indicates the email/password combination is invalid
          // or the credential has expired (for example, for federated providers).
          return Left(FirebaseFailure('The email or password is incorrect.'));
        case 'user-disabled':
          return Left(FirebaseFailure('This user account has been disabled.'));
        case 'too-many-requests':
          return Left(FirebaseFailure('Too many attempts. Try again later.'));
        case 'network-request-failed':
          return Left(FirebaseFailure('Network error. Check your connection.'));
        case 'operation-not-allowed':
          return Left(FirebaseFailure('Password sign-in is disabled in Firebase.'));
        default:
          return Left(
            FirebaseFailure(
              'Sign-in failed:,${e.code} & ${e.message ?? 'Unknown error'}',
            ),
          );
      }
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
  @override
Future<Either<Failure, LogInEntity>> getCurrentUser() async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return Right(
        LogInEntity(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        ),
      );
    } else {
      return Left(
      FirebaseFailure( "No user is currently signed in."),
      );
    }
  } catch (e) {
    return Left(
      FirebaseFailure(e.toString()),
    );
  }
}


}
