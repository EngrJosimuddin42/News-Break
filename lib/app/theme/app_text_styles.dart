import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Display - Cormorant Garamond (serif, editorial)
  static TextStyle get displayLarge => GoogleFonts.cormorantGaramond(
    fontSize: 48,
    fontWeight: FontWeight.w500,
    color: AppColors.textOnDark,
    height: 1.1,
  );

  static TextStyle get displayMedium => GoogleFonts.inter(   //
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.surface,
    height: 1.15,
  );

  static TextStyle get displaySmall => GoogleFonts.cormorantGaramond(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  // Display Italic (for "Finally", "your profile" etc.)
  static TextStyle get displayItalic => GoogleFonts.cormorantGaramond(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: AppColors.accent,
    height: 1.15,
  );

  static TextStyle get displayItalicLarge => GoogleFonts.cormorantGaramond(
    fontSize: 48,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    color: AppColors.accent,
    height: 1.1,
  );

  static TextStyle get displayItalicSmall => GoogleFonts.cormorantGaramond(
    fontSize: 30,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: AppColors.accent,
    height: 1.2,
  );

  // Headline - DM Sans (clean, modern)
  static TextStyle get headlineLarge => GoogleFonts.inter(  //
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.linkColor,
    height: 1.3,
  );

  static TextStyle get headlineMedium => GoogleFonts.cormorantGaramond(
    fontSize: 30,
    fontWeight: FontWeight.w500,
    color: AppColors.textOnDarkSecondary,
    height: 1.3,
  );

  static TextStyle get headlineSmall => GoogleFonts.dmSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Body
  static TextStyle get bodyLarge => GoogleFonts.inter(  //
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary1,
    height: 1.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(   //
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.surface,
    height: 1.5,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(  //
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.background,
    height: 1.4,
  );

  // Label
  static TextStyle get labelLarge => GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
  );

  static TextStyle get labelMedium => GoogleFonts.inter(  //
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.surface,
    letterSpacing: 0.5,
  );

  static TextStyle get labelSmall => GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textOnDarkSecondary,
    letterSpacing: 0.5,
    textBaseline: TextBaseline.alphabetic,
  );

  // Button
  static TextStyle get button => GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textOnDark,
    letterSpacing: 0.2,
  );

  static TextStyle get buttonOutline => GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.2,
  );

  // Caption / Overline
  static TextStyle get caption => GoogleFonts.dmSans(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    letterSpacing: 0.4,
  );

  static TextStyle get overline => GoogleFonts.dmSans(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.accent,
    letterSpacing: 1.5,
  );

  // Splash specific
  static TextStyle get splashBrand => GoogleFonts.cormorantGaramond(
    fontSize: 52,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    height: 1.0,
  );

  static TextStyle get splashTagline => GoogleFonts.cormorantGaramond(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    color: AppColors.accent,
  );
}