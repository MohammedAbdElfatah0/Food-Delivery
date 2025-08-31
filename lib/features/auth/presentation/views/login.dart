import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/contents/text_string.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/core/style/app_size.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_header_auth.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_test_form_filed.dart';
import '../widget/custom_divider.dart';
import '../widget/custom_method_sign_in.dart';
import '../widget/custom_text_register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
//TODO::connect firebase or api
//TODO::opition google /facebook apple
//TODO :: rebuild validation

Widget _header(String text) {
  return Text(text);
}

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeaderAuth(
                  text: TextString.headerLogin,
                  subText: TextString.headerSubLogin,
                ),
                AppSize.applyPadding(height: 12),
                _header(TextString.headerEmail),
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
                AppSize.applyPadding(height: 10),
                _header(TextString.headerPassword),
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
                    if (value.length < 6) {
                      return "inValid Password";
                    }
                    return null;
                  },
                ),
                AppSize.applyPadding(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        //todo:: navigator to forget screen
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
                AppSize.applyPadding(height: 4),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();

                      final isValid =
                          _formKey.currentState?.validate() ?? false;

                      if (!isValid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pls enter all filed')),
                        );
                        return;
                      }

                      Navigator.pushReplacementNamed(
                        context,
                        ContentsRouter.home,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 140,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        TextString.submit,
                        style: AppTextStyle.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ),
                ),

                AppSize.applyPadding(height: 8),
                CustomDivider(),
                AppSize.applyPadding(height: 8),
                CustomMethodSignIn(),
                AppSize.applyPadding(height: 8),
                CustomTextRegister(),
                AppSize.applyPadding(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
