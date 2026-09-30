import 'package:flutter/material.dart';

/// AppColors encapsulates the obsidian glassmorphism design system
/// defined in DESIGN.md.
class AppColors {
  // Obsidian Dark Surfaces
  static const Color surface = Color(0xFF0F131D);
  static const Color surfaceDim = Color(0xFF0F131D);
  static const Color surfaceBright = Color(0xFF353944);
  static const Color surfaceContainerLowest = Color(0xFF0A0E18);
  static const Color surfaceContainerLow = Color(0xFF171B26);
  static const Color surfaceContainer = Color(0xFF1B1F2A);
  static const Color surfaceContainerHigh = Color(0xFF262A34);
  static const Color surfaceContainerHighest = Color(0xFF313540);

  // Content / On-Surface Colors
  static const Color onSurface = Color(0xFFDFE2F0);
  static const Color onSurfaceVariant = Color(0xFFB9CACB);
  static const Color outline = Color(0xFF849495);
  static const Color outlineVariant = Color(0xFF3B494B);

  // Primary Accent: Electric Cyan (#00F0FF / #00DBE9)
  static const Color primary = Color(0xFFDBFCFF);
  static const Color onPrimary = Color(0xFF00363A);
  static const Color primaryContainer = Color(0xFF00F0FF);
  static const Color onPrimaryContainer = Color(0xFF006970);
  static const Color primaryFixed = Color(0xFF7DF4FF);
  static const Color primaryFixedDim = Color(0xFF00DBE9);

  // Secondary Accent: Warm Amber/Coral (#FF6B4A / #FFB4A3)
  static const Color secondary = Color(0xFFFFB4A3);
  static const Color onSecondary = Color(0xFF630F00);
  static const Color secondaryContainer = Color(0xFF8F1B01);
  static const Color onSecondaryContainer = Color(0xFFFFA08A);
  static const Color amberCoral = Color(0xFFFF6B4A);

  // Tertiary Accent: Auxiliary Violet (#A78BFA / #E0D3FF)
  static const Color tertiary = Color(0xFFFAF4FF);
  static const Color onTertiary = Color(0xFF381385);
  static const Color tertiaryContainer = Color(0xFFE0D3FF);
  static const Color onTertiaryContainer = Color(0xFF674BB6);
  static const Color auxiliaryViolet = Color(0xFFA78BFA);

  // Error Colors
  static const Color error = Color(0xFFFFB4AB);
  static const Color errorContainer = Color(0xFF93000A);

  // Key Colors
  static const Color keyNumericBg = Color(0xFF131825);
  static const Color keyNumericText = Color(0xFFE6EDF8);
  static const Color keyScientificText = Color(0xFF7B8A9E);
  static const Color keyAltText = Color(0xFF414E62);
}
