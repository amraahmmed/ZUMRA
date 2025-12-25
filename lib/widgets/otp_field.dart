import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:zumra/widgets/app_typography.dart';

class OtpField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onCompleted;

  const OtpField({
    super.key,
    required this.controller,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: AppTypography.headline,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(15),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration
          ?.copyWith(color: const Color.fromRGBO(234, 239, 243, 1)),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Pinput(
          length: 6,
          controller: controller,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
          onCompleted: onCompleted,
        ),
      ],
    );
  }
}