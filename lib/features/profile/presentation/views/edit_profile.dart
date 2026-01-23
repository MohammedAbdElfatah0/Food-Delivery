import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/contents/enum.dart';
import 'package:food_delivery/core/model/user_model.dart';
import 'package:food_delivery/features/profile/presentation/widget/edit_text_profile.dart';

import '../../../../core/di/servier_locator.dart';
import '../../../../core/style/app_text_style.dart';
import '../cubit/info_profile_cubit.dart';
import '../widget/gender_drop_down.dart';
import '../widget/profile_profile_and_info.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final birthController = TextEditingController();
  final genderController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    birthController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: ColorManager.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Personal Date',
          style: AppTextStyle.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: ColorManager.black,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider<InfoProfileCubit>(
        create: (_) => sl<InfoProfileCubit>()..getProfile(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const PhotoProfileAndInfo(),
                const SizedBox(height: 20),
                BlocListener<InfoProfileCubit, InfoProfileState>(
                  listener: (context, state) {
                    if (state is InfoProfileSuccess) {
                      final user = state.userModel;

                      nameController.text = user.name;
                      emailController.text = user.email;
                      phoneController.text = user.phone ?? "";
                      birthController.text = user.birthday.substring(
                        0,
                        user.birthday.indexOf("T"),
                      );
                      genderController.text = user.gender.name;
                    }
                  },
                  child: BlocBuilder<InfoProfileCubit, InfoProfileState>(
                    builder: (context, state) {
                      final UserModel? user =
                          state is InfoProfileSuccess ? state.userModel : null;
                      final String selectedGender =
                          user?.gender.name ?? GENDER.male.name;
                      return Column(
                        children: [
                          EditTextPrpfile(
                            text: "Full Name",
                            controller: nameController,
                            hintText: user?.name ?? "",
                          ),
                          EditTextPrpfile(
                            text: "Email",
                            controller: emailController,
                            hintText: user?.email ?? "",
                          ),
                          EditTextPrpfile(
                            text: "Phone",
                            controller: phoneController,
                            hintText: user?.phone ?? "No Phone",
                          ),
                          EditTextPrpfile(
                            text: "Birth Date",
                            controller: birthController,
                            hintText:
                                user?.birthday.substring(
                                  0,
                                  user.birthday.indexOf("T"),
                                ) ??
                                "",
                          ),
                          GenderDropDown(
                            selectedGender: selectedGender,
                            onChange: (gender) {
                              setState(() {
                                genderController.text = gender ?? '';
                              });
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 12),
        elevation: 3,
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      onPressed: () {
        // TODO: Implement save functionality
        log("save");
        log("name: ${nameController.text}");
        log("email: ${emailController.text}");
        log("phone: ${phoneController.text}");
        log("birth: ${birthController.text}");
        log("gender: ${genderController.text}");
      },
      child: Text('Save', style: AppTextStyle.bodyLarge),
    );
  }
}
