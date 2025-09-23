import 'package:flutter/cupertino.dart';

class ValidationTextField {
  static String? Function(String?)? email() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'pls enter email';
      }
      if (!value.contains("@")) {
        return "Enter a valid email";
      }
      return null;
    };
  }

  static String? Function(String?)? name() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your username';
      }
      if (value.length < 3) {
        return 'Username must be at least 3 characters long';
      }
      return null;
    };
  }

  static String? Function(String?)? password() {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return "Please enter a password";
      }
      if (value.length < 8) {
        return "Password must be at least 8 characters long";
      }
      // Optional: Add more validation rules
      if (!RegExp(r'^(?=.*[A-Z])(?=.*\d).+$').hasMatch(value)) {
        return "Password must contain at least one uppercase letter and one number";
      }
      return null;
    };
  }

  static String? Function(String?)? confirmPassword(
    TextEditingController controller,
  ) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your confirm password';
      }
      if (value.length < 8) {
        return 'Username must be at least 8 characters long';
      }
      if (value != controller.text) {
        return 'Passwords do not match';
      }
      return null;
    };
  }
}
