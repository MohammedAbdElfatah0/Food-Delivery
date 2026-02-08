import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/features/profile/data/repository/profile_romote_implement_repository.dart';
import 'package:food_delivery/features/profile/domain/repository/profile_repository.dart';
import 'package:food_delivery/features/profile/presentation/cubit/info_profile_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/profile/domain/use_case/get_profile_info.dart';
import '../../features/profile/domain/use_case/get_user_by_email.dart';
import '../../features/profile/domain/use_case/update_profile.dart';
import '../../features/profile/presentation/cubit/edit_profile_cubit.dart';
import '../contents/enum.dart';
import '../model/user_model.dart';
import '../service/firebase_store_service.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Cubit
  sl.registerFactory(() => InfoProfileCubit(sl()));
  sl.registerFactory(() => EditProfileCubit(sl<UpdateProfile>()));

  // UseCases
  sl.registerLazySingleton(() => GetProfileInfo(sl()));
  sl.registerLazySingleton(() => UpdateProfile(sl()));
  sl.registerLazySingleton(() => GetUserByEmail(sl()));

  // Repositories
  sl.registerLazySingleton<ProfileRepository>(
    () => sl<ProfileRomoteImplementRepository>(),
  );

  sl.registerLazySingleton<ProfileRomoteImplementRepository>(
    () =>
        ProfileRomoteImplementRepository(sl<FirebaseStoreService<UserModel>>()),
  );

  // Firebase service
  sl.registerLazySingleton(
    () => FirebaseStoreService<UserModel>(
      collectionPath: StoreKey.users.name,
      firestore: FirebaseFirestore.instance,
      fromMap: UserModel.fromMap,
    ),
  );
}
