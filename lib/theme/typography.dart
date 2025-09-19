import 'package:flutter/material.dart';
import 'colors.dart';

class AppText {
  static TextStyle get h1 => const TextStyle(
    fontFamily: 'Aeonik',
    fontWeight: FontWeight.bold,
    fontSize: 80,
    height: 1.0,
    color: AppColors.primary,
    letterSpacing: -1.5,
  );

  static TextStyle get h2 => const TextStyle(
    fontFamily: 'Aeonik',
    fontWeight: FontWeight.bold,
    fontSize: 36,
    height: 1.2,
    color: AppColors.primary,
  );

  static TextStyle get h3 => const TextStyle(
    fontFamily: 'Aeonik',
    fontWeight: FontWeight.w600,
    fontSize: 22,
    color: AppColors.primary,
  );

  static TextStyle get body => const TextStyle(
    fontFamily: 'Aeonik',
    fontSize: 16,
    height: 1.6,
    color: AppColors.secondary,
  );

  static TextStyle get small => const TextStyle(
    fontFamily: 'Aeonik',
    fontSize: 13,
    height: 1.5,
    color: AppColors.secondary,
  );
}
