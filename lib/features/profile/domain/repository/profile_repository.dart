import 'package:dartz/dartz.dart';
import 'package:food_delivery/core/model/user_model.dart';

abstract class ProfileRepository {
  Future<Either<String, UserModel>> getProfileInfo(String userID);
  Future<Either<String, Unit>> updateProfile(UserModel user);
  Future<Either<String, Unit>> deleteAccount({required String password});
  Future<Either<String, UserModel>> getUserByEmail(String email);
}
