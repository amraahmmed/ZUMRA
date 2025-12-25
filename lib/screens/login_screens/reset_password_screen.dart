import 'package:flutter/material.dart';
import 'package:zumra/screens/login_screens/password_changed_screen.dart';
import 'package:zumra/widgets/app_typography.dart';
import 'package:zumra/widgets/custom_button.dart';
import 'package:zumra/widgets/custom_sizedbox.dart';
import 'package:zumra/widgets/custom_textfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PasswordChangedScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/back.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(color: Colors.white.withOpacity(0.7)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpace.h40,
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  AppSpace.h20,
                  Text(
                    "Don't mess it up!",
                    style: AppTypography.headline,
                  ),
                  AppSpace.h8,
                  Text(
                    "This time.\nRemember your Password.",
                    style: AppTypography.subHead,
                  ),
                  AppSpace.h80,
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hint: "New Password",
                          icon: Icons.lock_outline,
                          isPassword: true,
                          obscureText: _obscurePassword,
                          controller: _passwordController,
                          onToggle: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            }
                            if (value.length < 8) {
                              return "Password must be at least 8 characters";
                            }
                            if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                            return 'Must contain an uppercase letter';
                            }
                            if (!RegExp(r'(?=.*[0-9])').hasMatch(value)) {
                              return 'Must contain a number';
                            }
                            if (!RegExp(r'(?=.*[!@#$%^&*(),.?":{}|<>])')
                                .hasMatch(value)) {
                              return 'Must contain a special character';
                            }
                            return null;
                          },
                        ),
                        AppSpace.h20,
                        CustomTextField(
                          hint: "Re-Type your Password",
                          icon: Icons.lock_outline,
                          isPassword: true,
                          obscureText: _obscureConfirmPassword,
                          controller: _confirmPasswordController,
                          onToggle: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }
                            if (value != _passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    text: "Change my Password",
                    onPressed: _changePassword,
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