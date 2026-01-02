import 'package:flutter/material.dart';
import 'package:zumra/services/auth_service.dart';
import 'package:zumra/widgets/app_typography.dart';
import 'package:zumra/widgets/custom_button.dart';
import 'package:zumra/widgets/custom_sizedbox.dart';
import 'package:zumra/widgets/custom_textfield.dart';
import 'code_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendCode() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await AuthService.forgotPassword(email: _emailController.text);
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CodeScreen(email: _emailController.text),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
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
                  AppSpace.h40,

                  /// Back Button
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),

                  AppSpace.h20,

                  /// Title
                  Text(
                    "Forgot Password?",
                    style: AppTypography.headline,
                  ),

                  AppSpace.h8,

                  Text(
                    "Don’t worry.\nLet’s recover it!",
                    style: AppTypography.subHead,
                  ),

                  /// 👇 بدل Center
                  AppSpace.h80,

                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Type your registered email here.",
                          style: AppTypography.inputLabel,
                        ),
                        AppSpace.h8,
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
                              // ignore: valid_regexps
                              r'^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$',
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
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: "Send code",
                          onPressed: _sendCode,
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