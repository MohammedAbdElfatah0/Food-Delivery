import 'package:flutter/material.dart';
import '../../../../core/Colors/color_manager.dart';
import '../../../../core/contents/images.dart';
import '../../../../core/model/user_model.dart';
import '../../../../core/style/app_text_style.dart';

class PhotoProfileAndInfo extends StatelessWidget {
  const PhotoProfileAndInfo({super.key, required UserModel? userModel})
    : _userModel = userModel;

  final UserModel? _userModel;

  @override
  Widget build(BuildContext context) {
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
          _userModel?.name ?? "Unknown User",
          style: AppTextStyle.header6.copyWith(
            color: ColorManager.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.001),
        Text(
          _userModel?.email ?? "",
          style: AppTextStyle.bodyLarge.copyWith(
            color: ColorManager.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
