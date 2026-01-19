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
      print({"res": res});
      return res;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserModel> getProfileInfo(String userID) async {
    final res = await fetchProfileInfo(userID);
    if (res == null) {
      throw Exception('User not found for id: ' + userID);
    }
    return res;
  }
}
