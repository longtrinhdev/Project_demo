import 'package:doulingo/core/config/theme/app_theme.dart';
import 'package:doulingo/presentation/splash/splash_page.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Duolingo 2025',
      theme: AppTheme.appTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
