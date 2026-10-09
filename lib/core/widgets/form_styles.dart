import 'package:coma/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

//* Label shown above dialog form fields
class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.onSurface, fontSize: 15),
      ),
    );
  }
}

//* Filled, borderless input used in dialog forms
InputDecoration formInputDecoration(String hint, {Widget? suffixIcon}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: AppColors.onSurfaceVariant),
    filled: true,
    fillColor: AppColors.background,
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );
}
