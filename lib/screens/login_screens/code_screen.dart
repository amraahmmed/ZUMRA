import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zumra/screens/login_screens/reset_password_screen.dart';
import 'package:zumra/widgets/app_typography.dart';
import 'package:zumra/widgets/custom_button.dart';
import 'package:zumra/widgets/custom_sizedbox.dart';
import 'package:zumra/widgets/otp_field.dart';

class CodeScreen extends StatefulWidget {
  const CodeScreen({super.key});

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  late final TextEditingController _otpController;
  String? _error;

  Timer? _timer;
  int _secondsRemaining = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _canResend = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        if (mounted) {
          setState(() {
            _canResend = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _secondsRemaining--;
          });
        }
      }
    });
  }

  void _resendCode() {
    if (!_canResend) return;
    _startTimer();
  }

    void _submit() {
    if (_otpController.text.length != 6) {
      setState(() {
        _error = "Please enter the 6-digit code";
      });
    } else {
      setState(() {
        _error = null;
      });
      debugPrint("OTP: ${_otpController.text}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen(),
        ),
      );
    }
  }


  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  String get _timerText {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/bg.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.75),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpace.h50,
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                  ),
                  AppSpace.h20,
                  Text(
                    "Check Your Email.",
                    style: AppTypography.headline,
                  ),
                  AppSpace.h8,
                  Text(
                    "We send you a code\nType it in the box.",
                    style: AppTypography.subHead,
                  ),
                  AppSpace.h80,
                  Text(
                    "Enter the code here",
                    style: AppTypography.inputLabel,
                  ),
                  AppSpace.h16,
                  OtpField(
                    controller: _otpController,
                  ),
                  if (_error != null) ...[
                    AppSpace.h8,
                    Text(
                      _error!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 13,
                      ),
                    ),
                  ],
                  const Spacer(),
                  Center(
                    child: GestureDetector(
                      onTap: _canResend ? _resendCode : null,
                      child: Text(
                        _canResend
                            ? "Didn’t receive a code? Resend"
                            : "Resend code in $_timerText",
                        style: AppTypography.inputLabel.copyWith(
                          decoration: _canResend
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          color:
                              _canResend ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  AppSpace.h16,
                  CustomButton(
                    text: "Done",
                    onPressed: _submit,
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