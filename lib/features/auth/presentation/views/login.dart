import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/contents/text_string.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/core/style/app_size.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/features/auth/data/repositories/firebase_auth_repositories.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_header_auth.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_test_form_filed.dart';
import 'package:food_delivery/features/auth/presentation/widget/header.dart';
import '../widget/custom_button_auth.dart';
import '../widget/custom_divider.dart';
import '../widget/custom_method_sign_in.dart';
import '../widget/custom_text_register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
//TODO::connect firebase or api ✅ firebase+ problems
//TODO::opition google /facebook apple
//TODO :: rebuild validation

class _LoginState extends State<Login> {
  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  Future<void> logIn() async {
    log(":::::::::::::::startLog::::::::::::");
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all fields correctly')),
      );
      return;
    }

    log(":::::::::::::::Loading::::::::::::");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    log(":::::::::::::::firebase::::::::::::");
    try {
      log(":::::::::::::::call firebase::::::::::::");
      final user = await FirebaseAuthRepositories().signIn(
        _emailEditingController.text.trim(),
        _passwordEditingController.text.trim(),
      );

      // Reload the user to ensure state is updated
      if (user != null) {
        await FirebaseAuth.instance.currentUser?.reload(); // اضافة للتأكيد
        log("User reloaded: ${user.id} ${user.name}");
      }

      Navigator.pop(context); // إغلاق الـ loading

      // Fallback navigation إذا الـ Stream مش حدث
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          ContentsRouter.home, // تأكد إن الـ route ده موجود في NavigatorRoute
          (route) => false,
        );
      }
    } catch (e) {
      log(":::::::::::::::pop Loading::::::::::::");
      Navigator.pop(context);
      String errorMessage = 'An error occurred. Please try again.';
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No user found with this email.';
            break;
          case 'wrong-password':
            errorMessage = 'Incorrect password. Please try again.';
            break;
          case 'invalid-email':
            errorMessage = 'Invalid email format.';
            break;
          default:
            errorMessage = 'Sign-in failed: ${e.message}';
        }
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    log(":::::::::::::::::::::::::::::::::LOGIN:::::::::::::::::::::::::");
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 72),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomHeaderAuth(
                    text: TextString.headerLogin,
                    subText: TextString.headerSubLogin,
                  ),
                  SizedBox(height: 32),
                  header(TextString.headerEmail),
                  SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _emailEditingController,
                    focusNode: _emailFocusNode,
                    hint: TextString.headerEmail,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
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
                  SizedBox(height: 24),
                  header(TextString.headerPassword),
                  SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _passwordEditingController,
                    focusNode: _passwordFocusNode,
                    hint: TextString.headerPassword,
                    isPassword: true,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "pls enter password";
                      }
                      if (value.length < 8) {
                        return "inValid Password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          //todo:: navigator to forget screen
                          //for check user exist or not
                          Navigator.pushNamed(
                            context,
                            ContentsRouter.forgetPassword,
                          );
                        },
                        child: Text(
                          TextString.headerForgetPassword,
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: ColorManager.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: CustomButtonAuth(
                      text: TextString.submit,
                      onTap: logIn,
                    ),
                  ),

                  SizedBox(height: 24),
                  CustomDivider(),
                  SizedBox(height: 24),
                  CustomMethodSignIn(),
                  SizedBox(height: 32),
                  CustomTextRegister(),
                  AppSize.applyPadding(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
