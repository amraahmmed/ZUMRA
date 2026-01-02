import 'package:flutter/material.dart';
import 'package:zumra/screens/login_screens/user_details_screen.dart';
import 'package:zumra/widgets/app_typography.dart';
import 'package:zumra/widgets/custom_button.dart';
import 'package:zumra/widgets/custom_sizedbox.dart';
import 'package:zumra/widgets/custom_textfield.dart';

class SetPasswordScreen extends StatefulWidget {
  final String email;
  const SetPasswordScreen({super.key, required this.email});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _setPassword() {
    if (_formKey.currentState!.validate()) {
      debugPrint("Password Set : ${_passwordController.text}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserDetailsScreen(
            email: widget.email,
            password: _passwordController.text.trim(),
          ),
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
            child: Image.asset("assets/images/back.jpg", fit: BoxFit.cover),
          ),
          Container(color: Colors.white.withOpacity(0.7)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpace.h50,
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  AppSpace.h20,
                  Text("Next Privacy.", style: AppTypography.headline),
                  AppSpace.h8,
                  Text("Type your Password.", style: AppTypography.subHead),
                  AppSpace.h80,
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hint: "Password",
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
                            if (!RegExp(
                              r'(?=.*[!@#$%^&*(),.?":{}|<>])',
                            ).hasMatch(value)) {
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
                  CustomButton(text: "Next", onPressed: _setPassword),
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
