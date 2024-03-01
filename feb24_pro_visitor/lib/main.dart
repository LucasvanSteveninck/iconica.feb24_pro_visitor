import 'package:feb24_pro_visitor/src/ui/login/test_stream.dart';
import 'package:feb24_pro_visitor/src/ui/qr_code/qr_code_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:feb24_pro_visitor/src/ui/splash/splash_Screen.dart';
import 'package:feb24_pro_visitor/src/ui/login/login_screen.dart';
import 'package:feb24_pro_visitor/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:feb24_pro_visitor/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //FirebaseAuth.instance
  //    .signInWithEmailAndPassword(email: 'a@gmail.com', password: '123jkl');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: customTheme,
      initialRoute: '/splash',
      routes: {
        '/': (context) => QrCodeScreen(),
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/qr-code': (context) => QrCodeScreen(),

      },
    );
  }
}
