import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/contents/text_string.dart';
import 'package:food_delivery/core/helper/validation_text_field.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/core/style/app_size.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_button_auth.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_divider.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_header_auth.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_method_sign_in.dart';
import 'package:food_delivery/features/auth/presentation/widget/header.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_text_register.dart';

import '../cubit/login/login_cubit.dart';
import '../widget/custom_test_form_filed.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _signIn() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      context.read<LoginCubit>().signIn(
            _emailEditingController.text.trim(),
            _passwordEditingController.text.trim(),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all fields correctly')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else if (state is LoginSuccess) {
            Navigator.pop(context); // Close loading dialog
            Navigator.pushNamedAndRemoveUntil(
              context,
              ContentsRouter.home,
              (route) => false,
            );
          } else if (state is LoginFailure) {
            Navigator.pop(context); // Close loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: SingleChildScrollView(
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
                      validator: ValidationTextField.email(),
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
                      validator: ValidationTextField.password(),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
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
                        onTap: _signIn,
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
      ),
    );
  }
}