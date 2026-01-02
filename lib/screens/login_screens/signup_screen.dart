import 'package:flutter/material.dart';
import 'package:zumra/screens/login_screens/set_password_screen.dart';
import 'package:zumra/widgets/app_typography.dart';
import 'package:zumra/widgets/custom_button.dart';
import 'package:zumra/widgets/custom_sizedbox.dart';
import 'package:zumra/widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  void _next() {
    if (_formKey.currentState!.validate()) {
      debugPrint("Email: ${_emailController.text}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SetPasswordScreen(
            email: _emailController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          /// Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/images/back.jpg",
              fit: BoxFit.cover,
            ),
          ),

          /// Overlay
          Container(color: Colors.white.withOpacity(0.7)),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpace.h50,

                  /// Back Button
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),

                  AppSpace.h20,

                  /// Title
                  Text(
                    "Sign Up is Easy.",
                    style: AppTypography.headline,
                  ),

                  AppSpace.h8,

                  Text(
                    "Let's start with E-Mail.",
                    style: AppTypography.subHead,
                  ),

                  AppSpace.h120,
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: AppTypography.large,
                        ),
                        AppSpace.h8,
                        CustomTextField(
                          hint: "Example@email.com",
                          icon: Icons.email_outlined,
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  /// Button
                  CustomButton(
                    text: "Next",
                    onPressed: _next,
                  ),

                  AppSpace.h20,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}