import 'package:flutter/material.dart';
import 'package:zumra/screens/login_screens/confirmation_screen.dart';
import 'package:zumra/widgets/app_typography.dart';
import 'package:zumra/widgets/custom_button.dart';
import 'package:zumra/widgets/custom_sizedbox.dart';
import 'package:zumra/widgets/custom_textfield.dart';

class UserDetailsScreen extends StatefulWidget {
  final String email;
  const UserDetailsScreen({super.key, required this.email});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _next() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationScreen(
            email: widget.email,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.jpg', // background image
              fit: BoxFit.cover,
            ),
          ),
          Container(color: Colors.white.withOpacity(0.7)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                    AppSpace.h8,
                    Text(
                      "Type your name here.",
                      style: AppTypography.subHead,
                    ),
                    AppSpace.h80,
                    Text("Name", style: AppTypography.large),
                    AppSpace.h8,
                    CustomTextField(
                      controller: _nameController,
                      hint: 'Your Name',
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    AppSpace.h20,
                    Text("Phone Number", style: AppTypography.large),
                    AppSpace.h8,
                    CustomTextField(
                      controller: _phoneController,
                      hint: 'Your Phone Number',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const Spacer(),
                    CustomButton(
                      text: "Next",
                      onPressed: _next,
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