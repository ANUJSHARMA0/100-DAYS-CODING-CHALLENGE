import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NovaCalcApp());
}

class NovaCalcApp extends StatelessWidget {
  const NovaCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nova Calc',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.surface,
        colorScheme: const ColorScheme.dark(
          surface: AppColors.surface,
          primary: AppColors.primaryContainer,
          secondary: AppColors.secondary,
          tertiary: AppColors.tertiaryContainer,
          onSurface: AppColors.onSurface,
        ),
        useMaterial3: true,
      ),
      home: const MainNavigationScreen(),
    );
  }
}
