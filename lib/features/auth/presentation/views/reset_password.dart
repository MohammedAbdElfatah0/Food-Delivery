import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_app_bar.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_button_auth.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_header_auth.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_test_form_filed.dart';
import 'package:food_delivery/features/auth/presentation/widget/header.dart';

import '../../../../core/contents/text_string.dart';
import '../../../../core/style/app_size.dart';
import '../widget/custom_show_botton_sheet.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppBar(text: TextString.resetPassword),
                      AppSize.applyPadding(height: 12),
                      CustomHeaderAuth(
                        text: TextString.resetPassword,
                        subText: TextString.subResetPassword,
                      ),
                      AppSize.applyPadding(height: 4),
                      header(TextString.headerPassword),
                      CustomTextFormField(
                        controller: _newPasswordController,
                        focusNode: _newPasswordFocusNode,
                        hint: TextString.headerPassword,
                        isPassword: true,
                        onFieldSubmitted:
                            (p0) => FocusScope.of(
                              context,
                            ).requestFocus(_confirmPasswordFocusNode),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 8) {
                            return 'Username must be at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                      header(TextString.continues),
                      AppSize.applyPadding(height: 4),
                      header(TextString.headerRegisterConfirmPassword),
                      CustomTextFormField(
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocusNode,
                        hint: TextString.headerRegisterConfirmPassword,
                        isPassword: true,
                        onFieldSubmitted:
                            (p0) => FocusScope.of(context).unfocus(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 8) {
                            return 'Username must be at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                      header(TextString.continues),
                      AppSize.applyPadding(height: 16),
                    ],
                  ),
                ),
              ),
              CustomButtonAuth(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder:
                        (context) => BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 2),
                          child: CustomShowBottomSheet(),
                        ),
                  );
                  //TODO :: buttom Sheet
                },
                text: TextString.verifyAccount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
