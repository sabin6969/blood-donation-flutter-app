import 'package:blood_donation_flutter_app/views/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const OnboardingView(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
    );
  }
}
