import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/contents/enum.dart';
import '../../../../core/model/user_model.dart';
import '../../../../core/service/firebase_store_service.dart';

abstract class ProfileRomoteDataSource {
  FirebaseStoreService<UserModel> service = FirebaseStoreService<UserModel>(
    collectionPath: StoreKey.users.name,
    firestore: FirebaseFirestore.instance,
    fromMap: UserModel.fromMap,
  );
  ProfileRomoteDataSource(this.service);
  Future<UserModel?> fetchProfileInfo(String userID);
}
