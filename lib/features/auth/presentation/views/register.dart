import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/contents/text_string.dart';
import 'package:food_delivery/features/auth/data/repositories/firebase_auth_repositories.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_button_auth.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_divider.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_header_auth.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_test_form_filed.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_text_login.dart';
import 'package:food_delivery/features/auth/presentation/widget/header.dart';
import '../../../../core/helper/validation_text_field.dart';
import '../widget/custom_method_sign_in.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

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

  void Function()? register() => () async {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all fields correctly')),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final user = await FirebaseAuthRepositories().register(
        _nameTextEditingController.text.trim(),
        _emailTextEditingController.text.trim(),
        _passwordTextEditingController.text.trim(),
      );

      // Reload the user to ensure state is updated
      if (user != null) {
        await FirebaseAuth.instance.currentUser?.reload();
        log("User reloaded: ${user.id}");
      }

      Navigator.pop(context); // إغلاق الـ loading

      // Fallback navigation
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful! Welcome!')),
      );

      // Navigator.of(context);
    } on Exception catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: ${e.toString()}')),
      );
    }
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                  SizedBox(height: 12),
                  header(TextString.headerRegisterUserName),
                  SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _nameTextEditingController,
                    focusNode: _nameFocusNode,
                    hint: TextString.headerRegisterUserName,
                    onFieldSubmitted:
                        (p0) => FocusScope.of(
                          context,
                        ).requestFocus(_emailFocusNode),
                    validator: ValidationTextField.name(),
                  ),
                  SizedBox(height: 14),

                  header(TextString.headerEmail),
                  SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _emailTextEditingController,
                    focusNode: _emailFocusNode,
                    hint: TextString.headerEmail,
                    onFieldSubmitted:
                        (p0) => FocusScope.of(
                          context,
                        ).requestFocus(_passwordFocusNode),
                    validator: ValidationTextField.email(),
                  ),
                  SizedBox(height: 14),
                  header(TextString.headerPassword),
                  SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _passwordTextEditingController,
                    focusNode: _passwordFocusNode,
                    hint: TextString.headerPassword,
                    isPassword: true,
                    onFieldSubmitted:
                        (p0) => FocusScope.of(
                          context,
                        ).requestFocus(_confirmPasswordFocusNode),
                    validator: ValidationTextField.password(),
                  ),
                  SizedBox(height: 14),
                  header(TextString.headerRegisterConfirmPassword),
                  SizedBox(height: 8),
                  CustomTextFormField(
                    controller: _confirmPasswordTextEditingController,
                    focusNode: _confirmPasswordFocusNode,
                    hint: TextString.headerRegisterConfirmPassword,
                    isPassword: true,
                    onFieldSubmitted: (p0) => FocusScope.of(context).unfocus(),
                    validator: ValidationTextField.confirmPassword(
                      _passwordTextEditingController,
                    ),
                  ),
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: CustomButtonAuth(
                      onTap: register(),
                      text: TextString.submit,
                    ),
                  ),
                  SizedBox(height: 24),
                  CustomDivider(),
                  SizedBox(height: 24),
                  CustomMethodSignIn(),
                  SizedBox(height: 32),
                  CustomTextLogin(),
                  SizedBox(height: 14),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
