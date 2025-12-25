import 'package:flutter/material.dart';
import 'package:prelova/bottom_nav_page.dart';
// import 'package:prelova/forgot_password_page.dart';
// import 'package:prelova/login_page.dart';
// import 'package:prelova/otp_page.dart';
import 'package:prelova/home_page.dart';
// import 'package:prelova/reset_password_page.dart';
// import 'package:prelova/onboarding_page.dart';
// import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavPage(),
    );
  }
}
