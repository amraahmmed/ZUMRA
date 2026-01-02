import 'package:flutter/material.dart';
import 'package:zumra/screens/login_screens/login_screen.dart';
import 'package:zumra/services/auth_service.dart';
import 'package:zumra/widgets/app_typography.dart';
import 'package:zumra/widgets/custom_button.dart';
import 'package:zumra/widgets/custom_sizedbox.dart';
import 'package:zumra/widgets/custom_textfield.dart';

class ResendEmailScreen extends StatefulWidget {
  const ResendEmailScreen({super.key});

  @override
  State<ResendEmailScreen> createState() => _ResendEmailScreenState();
}

class _ResendEmailScreenState extends State<ResendEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _resendEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await AuthService.resendConfirmationEmail(email: _emailController.text);
        debugPrint("Email Resent: ${_emailController.text}");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Confirmation email resent successfully!')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
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
                  AppSpace.h50,

                  /// Back Button
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),

                  AppSpace.h20,

                  /// Title
                  Text(
                    "Resend Email Confirmation",
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
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: "Next",
                          onPressed: _resendEmail,
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