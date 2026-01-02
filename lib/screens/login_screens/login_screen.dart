import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zumra/screens/app/home_screen.dart';
import 'package:zumra/screens/login_screens/resend_email.dart';
import 'package:zumra/screens/login_screens/signup_screen.dart';
import 'package:zumra/screens/login_screens/forgot_password_screen.dart';
import 'package:zumra/services/auth_service.dart';
import 'package:zumra/widgets/app_typography.dart';
import 'package:zumra/widgets/custom_sizedbox.dart';
import 'package:zumra/widgets/custom_textfield.dart';
import 'package:zumra/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _apiError;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _apiError = null;
    });

    try {
      await AuthService.login(
        userName: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    } catch (e) {
      setState(() {
        _apiError = e.toString().replaceAll('Exception:', '');
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          /// ===== Background =====
          Positioned.fill(
            child: Image.asset(
              "assets/images/bg.jpg",
              fit: BoxFit.cover,
            ),
          ),

          /// ===== Overlay =====
          Container(color: Colors.white.withOpacity(0.7)),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ListView(
              children: [
                AppSpace.h50,

                /// Back
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                AppSpace.h20,
                Text("Let’s sign you in.", style: AppTypography.headline),
                AppSpace.h8,
                Text(
                  "Welcome Back.\nYou’ve been missed!",
                  style: AppTypography.subHead,
                ),

                AppSpace.h40,

                /// ===== Form =====
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email", style: AppTypography.large),
                      AppSpace.h8,
                      CustomTextField(
                        hint: "Example@mail.com",
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

                      AppSpace.h20,
                      Text("Password", style: AppTypography.large),
                      AppSpace.h8,
                      CustomTextField(
                        hint: "************",
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
                            return "Must contain uppercase letter";
                          }
                          if (!RegExp(r'(?=.*[0-9])').hasMatch(value)) {
                            return "Must contain number";
                          }
                          if (!RegExp(r'(?=.*[!@#$%^&*])').hasMatch(value)) {
                            return "Must contain special character";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                if (_apiError != null) ...[
                  AppSpace.h16,
                  Text(
                    _apiError!,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ],

                AppSpace.h16,

                /// Forget Password
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Forget Password?",
                      style: AppTypography.inputLabel.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),

                AppSpace.h8,

                /// Resend Confirmation
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ResendEmailScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Resend email confirmation",
                      style: AppTypography.inputLabel.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),

                AppSpace.h64,

                /// Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account? ",
                      style: AppTypography.inputLabel,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Register",
                        style: AppTypography.large.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                AppSpace.h8,

                /// Google Login
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/icons/google.svg",
                    height: 28,
                  ),
                  label: Text(
                    "Continue With Google",
                    style: AppTypography.subHead,
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(343, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                AppSpace.h8,

                /// Login Button
                CustomButton(
                  text: _isLoading ? "Signing in..." : "Sign in",
                  onPressed: _isLoading ? null : _login,
                ),

                AppSpace.h20,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
