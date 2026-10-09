import 'package:coma/core/theme/app_colors.dart';
import 'package:coma/features/auth/widgets/auth_buttons.dart';
import 'package:coma/features/auth/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 120, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Header
              const Text(
                'Coma',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const Text(
                'Empieza con una cuenta nueva',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.onSurface),
              ),
              const SizedBox(height: 24),

              //* Form
              AuthTextField(
                label: 'Correo electrónico',
                hint: 'Correo',
                icon: Icons.email,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 28),
              AuthTextField(
                label: 'Contraseña',
                hint: 'Contraseña',
                icon: Icons.lock,
                controller: _passwordController,
                isPassword: true,
              ),
              const SizedBox(height: 36),

              //* Actions
              AuthPrimaryButton(
                text: 'Registrarse',
                onPressed: () {
                  //TODO: Implement account registration
                },
              ),
              const SizedBox(height: 20),
              AuthOutlinedButton(
                text: 'Ya tengo una cuenta',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
