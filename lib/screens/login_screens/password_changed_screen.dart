import 'package:flutter/material.dart';
import 'package:zumra/screens/login_screens/login_screen.dart';
import 'package:zumra/widgets/app_typography.dart';
import 'package:zumra/widgets/custom_button.dart';
import 'package:zumra/widgets/custom_sizedbox.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

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
                  Text("Password Changed.", style: AppTypography.headline),
                  AppSpace.h8,
                  Text("Sign off from devices.", style: AppTypography.subHead),
                  Text("Privacy is everything!", style: AppTypography.subHead),
                  const Spacer(),
                  OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  label: Text(
                    "No, Let my devices alone.",
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
                  AppSpace.h20,
                  CustomButton(
                    text: "Sign off from all devices",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
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