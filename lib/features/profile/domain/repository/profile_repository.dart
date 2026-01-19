import 'package:food_delivery/core/model/user_model.dart';

abstract class ProfileRepository {

  Future<UserModel> getProfileInfo(String userID);
}