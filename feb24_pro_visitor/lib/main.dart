import 'package:feb24_pro_visitor/src/ui/splash/splash_Screen.dart';
import 'package:feb24_pro_visitor/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: customTheme,
      home: const SplashScreen(), 
    );
  }
}