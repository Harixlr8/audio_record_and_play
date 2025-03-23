import 'package:flutter/material.dart';
import 'package:voice_record/model/login_model.dart';
import 'package:voice_record/views/recording/recording_screen.dart';

class LoginViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  void togglePasswordVisibility(VoidCallback updateUI) {
    isPasswordVisible = !isPasswordVisible;
    updateUI();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    return null;
  }

  void login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      User user = User(
        email: emailController.text,
        password: passwordController.text,
      );
      // Proceed with login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RecordingScreen()),
      );
    }
  }
}
