import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_integration/firebase_options.dart';
import 'package:flutter/material.dart';
import 'zakat_welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const ZakatApp());
}

class ZakatApp extends StatelessWidget {
  const ZakatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zakat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF009688), 
        brightness: Brightness.light,
        fontFamily: 'Roboto', 
        scaffoldBackgroundColor: const Color(0xFF1D4D4D),

      ),
      home: const ZakatWelcomeScreen(),
    );
  }
}