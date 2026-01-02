import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/contents/images.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

class ProfilePage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
          child: Column(
            children: [
              _appBar(),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
              _photoProfileAndNameEmail(context),
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
                _listProfile.length,
                (index) => _profile(
                  title: _listProfile[index]["title"] as String,
                  icon: _listProfile[index]["icon"] as IconData,
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
                _listSupport.length,
                (index) => _profile(
                  title: _listSupport[index]["title"] as String,
                  icon: _listSupport[index]["icon"] as IconData,
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
              _logOut(),
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

  // todo stack ::::::::
  Widget _photoProfileAndNameEmail(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          maxRadius: MediaQuery.sizeOf(context).aspectRatio * 50 * 3,
          minRadius: MediaQuery.sizeOf(context).aspectRatio * 50 * 1,
          // radius: 50,
          //todo connect image by device or give for firebase if not null
          backgroundImage: AssetImage(ImageResources.drink),

          // child: Text(
          //   "M",
          //   style: AppTextStyle.header4.copyWith(
          //     fontWeight: FontWeight.bold,
          //     color: ColorManager.black,
          //   ),
          // ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.005),
        Text(
          "Mohammed Mohammed ",
          style: AppTextStyle.header6.copyWith(
            color: ColorManager.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.001),
        Text(
          "Mohammed Mohammed ",
          style: AppTextStyle.bodyLarge.copyWith(
            color: ColorManager.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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

  Widget _logOut() {
    return ElevatedButton(
      onPressed: () {},

      style: ElevatedButton.styleFrom(
        splashFactory: InkSplash.splashFactory,
        backgroundColor: Colors.transparent,
        elevation: 0,
        side: BorderSide(color: ColorManager.grey.withAlpha(60)),
        overlayColor: Colors.cyan.shade100,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.arrowRightFromBracket,
            color: ColorManager.error,
            size: 18,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              'Sign Out',
              style: AppTextStyle.bodyLarge.copyWith(
                color: ColorManager.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
