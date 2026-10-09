import 'package:coma/core/theme/app_colors.dart';
import 'package:coma/features/auth/screens/register_screen.dart';
import 'package:coma/features/auth/widgets/auth_buttons.dart';
import 'package:coma/features/auth/widgets/auth_text_field.dart';
import 'package:coma/features/auth/widgets/google_logo.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //* Header
              Text.rich(
                TextSpan(
                  style: theme.textTheme.titleLarge,
                  children: [
                    TextSpan(text: 'Inicia sesión en '),
                    TextSpan(text: 'Coma', style: TextStyle(color: AppColors.primary)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'O crea una cuenta nueva.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 40),

              //* Google sign in
              SizedBox(
                width: double.infinity,
                height: 48,
                child: TextButton.icon(
                  onPressed: () {
                    //TODO: Implement Google sign in
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.appBarBackground,
                    foregroundColor: AppColors.onSurface,
                    shape: const StadiumBorder(),
                  ),
                  icon: const GoogleLogo(size: 22),
                  label: const Text('Continuar con Google', style: TextStyle(fontSize: 15)),
                ),
              ),
              const SizedBox(height: 16),

              //* "Or email" divider
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.onSurfaceVariant)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('O con correo', style: TextStyle(color: AppColors.onSurface)),
                  ),
                  Expanded(child: Divider(color: AppColors.onSurfaceVariant)),
                ],
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
                labelTrailing: GestureDetector(
                  onTap: () {
                    //TODO: Implement password recovery
                  },
                  child: const Text('¿Olvidaste?', style: TextStyle(color: AppColors.primary, fontSize: 15)),
                ),
              ),
              const SizedBox(height: 32),

              //* Actions
              AuthPrimaryButton(
                text: 'Iniciar sesión',
                onPressed: () {
                  //TODO: Authenticate before entering the app
                  Navigator.of(context).pushReplacementNamed('/home');
                },
              ),
              const SizedBox(height: 16),
              AuthOutlinedButton(
                text: 'Crear cuenta nueva',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
