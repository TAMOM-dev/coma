import 'package:coma/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType? keyboardType;
  final Widget? labelTrailing; //* e.g. "Forgot?" link next to the label

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.controller,
    this.isPassword = false,
    this.keyboardType,
    this.labelTrailing,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.label,
                style: const TextStyle(color: AppColors.onSurface, fontSize: 15),
              ),
            ),
            ?widget.labelTrailing,
          ],
        ),
        const SizedBox(height: 10),
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscured,
          keyboardType: widget.keyboardType,
          style: const TextStyle(color: AppColors.onSurface),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: AppColors.onSurfaceVariant),
            filled: true,
            fillColor: AppColors.appBarBackground,
            prefixIcon: Icon(widget.icon, color: AppColors.onSurfaceVariant),
            //* Show/hide password toggle
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: AppColors.onSurfaceVariant,
                    ),
                    onPressed: () => setState(() => _obscured = !_obscured),
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
