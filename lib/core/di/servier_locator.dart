import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/features/profile/data/repository/profile_romote_implement_repository.dart';
import 'package:food_delivery/features/profile/domain/repository/profile_repository.dart';
import 'package:food_delivery/features/profile/presentation/cubit/info_profile_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:food_delivery/core/model/product_model.dart';
import 'package:food_delivery/features/home/data/repository/products_repository_impl.dart';
import 'package:food_delivery/features/home/domain/repository/products_repostiry.dart';
import 'package:food_delivery/features/home/domain/usecase/get_all_product.dart';
import 'package:food_delivery/features/home/domain/usecase/get_product_by_category.dart';
import 'package:food_delivery/features/home/presentation/cubit/product/product.cubit.dart';

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
  sl.registerFactory(
    () => ProductCubit(sl<GetAllProduct>(), sl<GetProductByCategory>()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetProfileInfo(sl()));
  sl.registerLazySingleton(() => UpdateProfile(sl()));
  sl.registerLazySingleton(() => GetUserByEmail(sl()));
  sl.registerLazySingleton(() => GetAllProduct(sl<ProductsRepostiry>()));
  sl.registerLazySingleton(() => GetProductByCategory(sl<ProductsRepostiry>()));

  // Repositories
  sl.registerLazySingleton<ProfileRepository>(
    () => sl<ProfileRomoteImplementRepository>(),
  );

  sl.registerLazySingleton<ProductsRepostiry>(
    () => sl<ProductsRepositoryImpl>(),
  );

  sl.registerLazySingleton<ProfileRomoteImplementRepository>(
    () =>
        ProfileRomoteImplementRepository(sl<FirebaseStoreService<UserModel>>()),
  );

  sl.registerLazySingleton<ProductsRepositoryImpl>(
    () => ProductsRepositoryImpl(sl<FirebaseStoreService<ProductModel>>()),
  );

  // Firebase service
  sl.registerLazySingleton(
    () => FirebaseStoreService<UserModel>(
      collectionPath: StoreKey.users.name,
      firestore: FirebaseFirestore.instance,
      fromMap: UserModel.fromMap,
    ),
  );

  sl.registerLazySingleton(
    () => FirebaseStoreService<ProductModel>(
      collectionPath: StoreKey.products.name,
      firestore: FirebaseFirestore.instance,
      fromMap: ProductModel.fromMap,
    ),
  );
}
