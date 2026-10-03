import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); //* Private constructor to prevent instantiation
  

  static const primary = Color(0xFFFF8C00);
  static const background = Color(0xFF0B1220);
  static const onSurface = Color(0xFFC4DCFF);
  static Color get onSurfaceVariant => onSurface.withValues(alpha: 0.6);
  static const surface = Color(0xFF0B1220);
  static const onPrimaryContainer = Color(0xFF624727);
  static const appBarBackground = Color(0xFF162039);
  static const warning = Color(0xFFE94768);
  

  //* Independent colors
  static const orderedLabelColor = Color(0xFF0cc0df);
}