import 'package:food_delivery/core/model/user_model.dart';
import 'package:food_delivery/features/profile/domain/repository/profile_repository.dart';

class GetProfileInfo {
  final ProfileRepository _profileRepository;

  GetProfileInfo(this._profileRepository);
  
  Future<UserModel> call(String userID) {
    return _profileRepository.getProfileInfo(userID);
  }
}
