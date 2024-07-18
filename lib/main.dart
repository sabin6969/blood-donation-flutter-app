import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/controllers/login_controller.dart';
import 'package:blood_donation_flutter_app/controllers/onboarding_controller.dart';
import 'package:blood_donation_flutter_app/controllers/register_controller.dart';
import 'package:blood_donation_flutter_app/firebase_options.dart';
import 'package:blood_donation_flutter_app/views/home_view.dart';
import 'package:blood_donation_flutter_app/views/login_signup_view.dart';
import 'package:blood_donation_flutter_app/views/login_view.dart';
import 'package:blood_donation_flutter_app/views/onboarding_view.dart';
import 'package:blood_donation_flutter_app/views/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// Global object to access height and width of a device
late Size size;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.onboardingView,
      defaultTransition: Transition.downToUp,
      getPages: [
        GetPage(
          name: AppRoutes.onboardingView,
          page: () => const OnboardingView(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => OnboardingController());
            },
          ),
        ),
        GetPage(
          name: AppRoutes.loginSignupView,
          page: () => const LoginSignupView(),
        ),
        GetPage(
          name: AppRoutes.loginView,
          page: () => const LoginView(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => LoginController());
            },
          ),
        ),
        GetPage(
          name: AppRoutes.signupView,
          page: () => const SignupView(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => RegisterController());
            },
          ),
        ),
        GetPage(
          name: AppRoutes.homeView,
          page: () => const HomeView(),
        ),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
    );
  }
}
