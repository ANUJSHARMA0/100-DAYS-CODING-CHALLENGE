import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// AppTypography configures JetBrains Mono and Space Grotesk font styles
/// as defined in DESIGN.md.
class AppTypography {
  // Display Result (JetBrains Mono)
  static TextStyle displayResult = GoogleFonts.jetBrainsMono(
    fontSize: 44,
    fontWeight: FontWeight.w400,
    height: 1.15,
    letterSpacing: -1.5,
    color: AppColors.primaryContainer,
  );

  static TextStyle displayResultMobile = GoogleFonts.jetBrainsMono(
    fontSize: 34,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: -1.0,
    color: AppColors.primaryContainer,
  );

  // Display Expression (JetBrains Mono)
  static TextStyle displayExpression = GoogleFonts.jetBrainsMono(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: AppColors.onSurface,
  );

  // Headline Sheet (Space Grotesk)
  static TextStyle headlineSheet = GoogleFonts.spaceGrotesk(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.5,
    color: AppColors.onSurface,
  );

  // Keypad Number (JetBrains Mono)
  static TextStyle keypadNumber = GoogleFonts.jetBrainsMono(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: AppColors.keyNumericText,
  );

  // Keypad Operator (Space Grotesk)
  static TextStyle keypadOperator = GoogleFonts.spaceGrotesk(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.amberCoral,
  );

  // Keypad Scientific (JetBrains Mono)
  static TextStyle keypadScientific = GoogleFonts.jetBrainsMono(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    color: AppColors.keyScientificText,
  );

  // Keypad Subscript (Space Grotesk)
  static TextStyle keypadSubscript = GoogleFonts.spaceGrotesk(
    fontSize: 9,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.keyAltText,
  );

  // Body Regular (JetBrains Mono)
  static TextStyle bodyRegular = GoogleFonts.jetBrainsMono(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );

  // Body Compact (JetBrains Mono)
  static TextStyle bodyCompact = GoogleFonts.jetBrainsMono(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
  );

  // Label Caps (Space Grotesk)
  static TextStyle labelCaps = GoogleFonts.spaceGrotesk(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
    color: AppColors.onSurfaceVariant,
  );
}
