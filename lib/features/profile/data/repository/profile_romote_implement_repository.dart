import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:food_delivery/core/model/user_model.dart';
import 'package:food_delivery/features/profile/data/remote/profile_romote_data_source.dart';
import 'package:food_delivery/features/profile/domain/repository/profile_repository.dart';

class ProfileRomoteImplementRepository extends ProfileRomoteDataSource
    implements ProfileRepository {
  ProfileRomoteImplementRepository(super.service);

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
}
