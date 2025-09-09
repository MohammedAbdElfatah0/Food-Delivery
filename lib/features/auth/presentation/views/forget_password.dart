import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/contents/text_string.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_button_auth.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_header_auth.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_show_model_bottom_sheet.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_test_form_filed.dart';
import '../../../../core/style/app_size.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _emailFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomHeaderAuth(
                      text: TextString.headerForgetPassword,
                      subText: TextString.headerSubForgetPassword,
                    ),
                    AppSize.applyPadding(height: 10),
                    CustomTextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      hint: TextString.headerEmail,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'pls enter email';
                        }
                        if (!value.contains("@")) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    AppSize.applyPadding(height: 10),
                  ],
                ),
              ),
            ),
            CustomButtonAuth(
              onTap: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                //if user is exist and //* true
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 4),
                      //TODO::send data to bottom sheet
                      child: ForgotPasswordBottomSheet(),
                    );
                  },
                );
              },
              text: TextString.continues,
            ),
          ],
        ),
      ),
    );
  }
}
