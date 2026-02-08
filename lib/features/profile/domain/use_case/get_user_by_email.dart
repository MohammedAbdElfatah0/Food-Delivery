import 'package:food_delivery/core/model/user_model.dart';
import 'package:food_delivery/features/profile/domain/repository/profile_repository.dart';

class GetUserByEmail {
  final ProfileRepository _profileRepository;

  GetUserByEmail(this._profileRepository);
  
  Future<UserModel> call(String email) async {
    final result = await _profileRepository.getUserByEmail(email);
    return result.fold((l) => throw Exception(l), (r) => r);
  }
}
