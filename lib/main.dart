import 'package:coma/core/theme/app_theme.dart';
import 'package:coma/core/widgets/main_shell.dart';
import 'package:coma/features/auth/screens/login_screen.dart';
import 'package:coma/features/home/screens/home_screen.dart';
import 'package:coma/features/home/screens/products_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/home': (_) => MainShell(
          titles: ['Inicio', 'Perfil', 'Productos'],
          pages: [
            HomeScreen(),
            Center(child: Text('Profile')),
            ProductsScreen(),
          ]
        ),
      },
    );
  }
}

