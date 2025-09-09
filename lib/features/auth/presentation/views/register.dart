import 'package:flutter/material.dart';
import 'package:food_delivery/core/contents/text_string.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_button_auth.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_divider.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_header_auth.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_test_form_filed.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_text_login.dart';
import 'package:food_delivery/features/auth/presentation/widget/header.dart';
import '../../../../core/style/app_size.dart';
import '../widget/custom_method_sign_in.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

//TODO : build ui
/***
 * 1-header
 * 2-text form filed
 * 3button 
 * 4-text button
 * 5-divider
 * 6-method sign in custom
 */

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
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
                  text: TextString.headerRegister,
                  subText: TextString.headerSubRegister,
                ),
                AppSize.applyPadding(height: 8),
                header(TextString.headerRegisterUserName),
                CustomTextFormField(
                  controller: _nameTextEditingController,
                  focusNode: _nameFocusNode,
                  hint: TextString.headerRegisterUserName,
                  onFieldSubmitted:
                      (p0) =>
                          FocusScope.of(context).requestFocus(_emailFocusNode),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    if (value.length < 3) {
                      return 'Username must be at least 3 characters long';
                    }
                    return null;
                  },
                ),
                AppSize.applyPadding(height: 4),
                header(TextString.headerEmail),
                CustomTextFormField(
                  controller: _emailTextEditingController,
                  focusNode: _emailFocusNode,
                  hint: TextString.headerEmail,
                  onFieldSubmitted:
                      (p0) => FocusScope.of(
                        context,
                      ).requestFocus(_passwordFocusNode),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains("@")) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                AppSize.applyPadding(height: 4),
                header(TextString.headerPassword),
                CustomTextFormField(
                  controller: _passwordTextEditingController,
                  focusNode: _passwordFocusNode,
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
                AppSize.applyPadding(height: 4),
                header(TextString.headerRegisterConfirmPassword),
                CustomTextFormField(
                  controller: _confirmPasswordTextEditingController,
                  focusNode: _confirmPasswordFocusNode,
                  hint: TextString.headerRegisterConfirmPassword,
                  isPassword: true,
                  onFieldSubmitted: (p0) => FocusScope.of(context).unfocus(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your confirm password';
                    }
                    if (value.length < 8) {
                      return 'Username must be at least 8 characters long';
                    }
                    if (value != _passwordTextEditingController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                AppSize.applyPadding(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: CustomButtonAuth(
                    onTap: () {
                      //validation here and navigation to login screen
                      FocusScope.of(context).unfocus();

                      final isValid =
                          _formKey.currentState?.validate() ?? false;

                      if (!isValid) {
                        //TODO:::refactor message error :::
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pls enter all filed')),
                        );
                        return;
                      }

                      Navigator.pop(context);
                    },
                    text: TextString.submit,
                  ),
                ),
                AppSize.applyPadding(height: 4),
                CustomDivider(),
                AppSize.applyPadding(height: 4),
                AppSize.applyPadding(height: 8),
                CustomMethodSignIn(),
                AppSize.applyPadding(height: 8),
                CustomTextLogin(),
                AppSize.applyPadding(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
