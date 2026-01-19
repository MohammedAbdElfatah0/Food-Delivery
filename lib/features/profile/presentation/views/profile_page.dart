import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/model/user_model.dart';
import 'package:food_delivery/core/shared/shared_preference.dart';
import 'package:food_delivery/core/shared/shared_preference_key.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

import '../../../../core/service/firebase_store_service.dart';
import '../widget/log_out_button.dart';
import '../widget/profile_profile_and_info.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  static const _listProfile = [
    {"title": "Personal Date", "icon": FontAwesomeIcons.person},
    {"title": "Setting", "icon": FontAwesomeIcons.gear},
    {"title": "Extra Card", "icon": FontAwesomeIcons.creditCard},
  ];
  static const _listSupport = [
    {"title": "Help Center", "icon": FontAwesomeIcons.circleInfo},
    {"title": "Delete Account", "icon": FontAwesomeIcons.userMinus},
    {"title": "Add anther Account", "icon": FontAwesomeIcons.userPlus},
  ];

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseStoreService<UserModel> _firebaseStoreService =
      FirebaseStoreService<UserModel>(
        collectionPath: StoreKey.users.name,
        firestore: FirebaseFirestore.instance,
        fromMap: UserModel.fromMap,
      );
  UserModel? _userModel;
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  //todo cubit
  Future<void> _loadUser() async {
    final String userId = AppPreferences.instance.getString(
      key: SharedPreferenceKey.userId,
    ); // getter أنضف

    if (userId.isEmpty) return; //null safety

    final user = await _firebaseStoreService.getOne(userId);

    if (!mounted) return;

    setState(() => _userModel = user);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
          child: Column(
            children: [
              _appBar(),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
              // todo stack ::::::::image edit photo
              PhotoProfileAndInfo(userModel: _userModel),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  "Profile",
                  style: AppTextStyle.header6.copyWith(
                    color: ColorManager.grey,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.005),
              ...List.generate(
                ProfilePage._listProfile.length,
                (index) => _profile(
                  title: ProfilePage._listProfile[index]["title"] as String,
                  icon: ProfilePage._listProfile[index]["icon"] as IconData,
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  "Support",
                  style: AppTextStyle.header6.copyWith(
                    color: ColorManager.grey,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.005),
              ...List.generate(
                ProfilePage._listSupport.length,
                (index) => _profile(
                  title: ProfilePage._listSupport[index]["title"] as String,
                  icon: ProfilePage._listSupport[index]["icon"] as IconData,
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Align(
      alignment: AlignmentGeometry.bottomCenter,
      child: Text(
        "Profile Settings",
        style: AppTextStyle.header6.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _profile({required String title, required IconData icon}) {
    return ListTile(
      leading: Icon(icon, size: 21),
      title: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          title,
          style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      trailing: Icon(FontAwesomeIcons.angleRight),
    );
  }
}
