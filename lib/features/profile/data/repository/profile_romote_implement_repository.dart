import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/core/model/user_model.dart';
import 'package:food_delivery/features/profile/data/remote/profile_romote_data_source.dart';
import 'package:food_delivery/features/profile/domain/repository/profile_repository.dart';

class ProfileRomoteImplementRepository extends ProfileRomoteDataSource
    implements ProfileRepository {
  ProfileRomoteImplementRepository(super.service, {this.auth});

  final FirebaseAuth? auth;
  @override
  Future<UserModel?> fetchProfileInfo(String userID) async {
    try {
      final res = await service.getOne(userID);

      return res;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Either<String, UserModel>> getProfileInfo(String userID) async {
    final res = await fetchProfileInfo(userID);
    if (res == null) {
      return left('User not found for id: $userID');
    }
    return right(res);
  }

  @override
  Future<Either<String, Unit>> updateProfile(UserModel user) async {
    try {
      await service.update(user);
      return right(unit);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> deleteAccount({required String password}) async {
    try {
      final user = auth?.currentUser;

      if (user == null) {
        throw Exception("User not logged in");
      }

      // 1️⃣ Re-auth
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);

      // 2️⃣ Delete Firestore data
      await service.delete(user.uid);

      // 3️⃣ Delete Auth account
      await user.delete();
      return right(unit);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, UserModel>> getUserByEmail(String email) async {
    try {
      final querySnapshot =
          await service.firestore
              .collection(service.collectionPath)
              .where('email', isEqualTo: email)
              .limit(1)
              .get();
      if (querySnapshot.docs.isEmpty) {
        return left('User not found with email: $email');
      }

      final userDoc = querySnapshot.docs.first;
      final userData = userDoc.data();
      final userModel = service.fromMap(userData);

      return right(userModel);
    } catch (e) {
      return left('Error searching for user by email: ${e.toString()}');
    }
  }
}
