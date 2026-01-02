import 'package:flutter/material.dart';
import 'package:zumra/screens/login_screens/confirmation_screen.dart';
import 'package:zumra/services/auth_service.dart';
import 'package:zumra/widgets/app_typography.dart';
import 'package:zumra/widgets/custom_button.dart';
import 'package:zumra/widgets/custom_sizedbox.dart';
import 'package:zumra/widgets/custom_textfield.dart';

class UserDetailsScreen extends StatefulWidget {
  final String email;
  final String password;

  const UserDetailsScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isLoading = false;
  String? _error;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await AuthService.register(
        name: _nameController.text.trim(),
        email: widget.email,
        phoneNumber: _phoneController.text.trim(),
        password: widget.password,
        confirmPassword: widget.password,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ConfirmationScreen(email: widget.email),
        ),
      );
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/bg.jpg", fit: BoxFit.cover),
          ),
          Container(color: Colors.white.withOpacity(0.7)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpace.h50,
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    AppSpace.h40,
                    Text(
                      "What about name\n& Phone Number.",
                      style: AppTypography.headline,
                    ),
                    AppSpace.h80,

                    CustomTextField(
                      controller: _nameController,
                      hint: "Your Name",
                      icon: Icons.person_outline,
                      validator: (v) =>
                          v == null || v.isEmpty ? "Name required" : null,
                    ),

                    AppSpace.h20,

                    CustomTextField(
                      controller: _phoneController,
                      hint: "Phone Number",
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (v) =>
                          v == null || v.isEmpty ? "Phone required" : null,
                    ),

                    if (_error != null) ...[
                      AppSpace.h16,
                      Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],

                    const Spacer(),

                    CustomButton(
                      text: "Create Account",
                      isLoading: _isLoading,
                      onPressed: _register,
                    ),

                    AppSpace.h20,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
