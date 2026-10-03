import 'package:coma/core/theme/app_colors.dart';
import 'package:coma/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._(); //* Private constructor to prevent instantiation

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.surface,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        onPrimary: Colors.white,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        primaryContainer: AppColors.primary,
        onPrimaryContainer: AppColors.onPrimaryContainer,
      ),

      //* Text Theme
      textTheme: TextTheme(
        titleLarge: AppTextStyle.titleLarge.copyWith(color: AppColors.onSurface),
        bodyMedium: AppTextStyle.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)
      ),

      //* App bar theme
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.appBarBackground,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          iconTheme: IconThemeData(color: AppColors.onSurfaceVariant),
        ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      //*Search bar theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: TextStyle(color: AppColors.onSurfaceVariant),
        prefixIconColor: AppColors.onSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ), 
      //*Floating button theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),

      //*Bottom Navigation Bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,

      )
    );
  }
  
}