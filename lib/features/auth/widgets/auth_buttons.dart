import 'package:coma/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

//* Filled orange pill button
class AuthPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const AuthPrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimaryContainer,
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        child: Text(text),
      ),
    );
  }
}

//* Orange outlined pill button
class AuthOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const AuthOutlinedButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        child: Text(text),
      ),
    );
  }
}
