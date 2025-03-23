import 'package:flutter/material.dart';
import 'package:voice_record/viewmodel/login_view_model.dart';
import 'package:voice_record/widgets/background_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LoginViewModel viewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BackgroundWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.1),
                  Image.asset('assets/images/Logo.png'),
                  const SizedBox(height: 10),
                  const Text(
                    'A A V A A Z',
                    style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: size.height * 0.25),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Email", style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: viewModel.emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Enter your email"),
                        validator: viewModel.validateEmail,
                      ),
                      const SizedBox(height: 8),
                      const Text("Password", style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: viewModel.passwordController,
                        obscureText: !viewModel.isPasswordVisible,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration("Enter your password").copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              viewModel.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              setState(() {
                                viewModel.togglePasswordVisibility(() => setState(() {}));
                              });
                            },
                          ),
                        ),
                        validator: viewModel.validatePassword,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Forgot password?", style: TextStyle(color: Colors.blue)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: const Color.fromARGB(255, 138, 193, 219),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () => viewModel.login(context),
                          child: const Text(
                            "Log In",
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text.rich(
                            TextSpan(
                              text: "Don’t have an account? ",
                              style: TextStyle(color: Colors.white),
                              children: [
                                TextSpan(
                                  text: "Sign up",
                                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration _inputDecoration(String hintText) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white10,
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.white54),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
  );
}
