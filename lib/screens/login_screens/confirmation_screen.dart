import 'package:flutter/material.dart';
import 'package:zumra/screens/login_screens/login_screen.dart';
import 'package:zumra/widgets/app_typography.dart';
import 'package:zumra/widgets/custom_button.dart';
import 'package:zumra/widgets/custom_sizedbox.dart';

class ConfirmationScreen extends StatelessWidget {
  final String email;
  const ConfirmationScreen({super.key, required this.email});

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
              child: Column(
                children: [
                  AppSpace.h50,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Check Your Email.",
                    style: AppTypography.headline,
                    textAlign: TextAlign.center,
                  ),
                  AppSpace.h8,
                  Text(
                    "We sent an Confirmation to\n$email",
                    style: AppTypography.subHead,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  CustomButton(
                    text: "Done",
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
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