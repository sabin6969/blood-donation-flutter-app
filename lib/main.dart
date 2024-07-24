import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/controllers/blood_request_controller.dart';
import 'package:blood_donation_flutter_app/controllers/login_controller.dart';
import 'package:blood_donation_flutter_app/controllers/onboarding_controller.dart';
import 'package:blood_donation_flutter_app/controllers/register_controller.dart';
import 'package:blood_donation_flutter_app/controllers/search_donor_controller.dart';
import 'package:blood_donation_flutter_app/controllers/splash_controller.dart';
import 'package:blood_donation_flutter_app/firebase_options.dart';
import 'package:blood_donation_flutter_app/views/blood_request_view.dart';
import 'package:blood_donation_flutter_app/views/campaings/campaigns_view.dart';
import 'package:blood_donation_flutter_app/views/donors_view.dart';
import 'package:blood_donation_flutter_app/views/landing_view.dart';
import 'package:blood_donation_flutter_app/views/auth/login_signup_view.dart';
import 'package:blood_donation_flutter_app/views/auth/login_view.dart';
import 'package:blood_donation_flutter_app/views/onboarding_view.dart';
import 'package:blood_donation_flutter_app/views/auth/register_view.dart';
import 'package:blood_donation_flutter_app/views/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((event) {
    debugPrint("A remote notification has been received");
  });
  await GetStorage.init();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

// Global object to access height and width of a device
late Size size;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.splashView,
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
              Get.lazyPut(
                () => RegisterController(),
              );
            },
          ),
        ),
        GetPage(
          name: AppRoutes.landingView,
          page: () => const LandingView(),
        ),
        GetPage(
          name: AppRoutes.donorsView,
          page: () => const DonorsView(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => SearchDonorController());
            },
          ),
        ),
        GetPage(
          name: AppRoutes.bloodRequestView,
          page: () => const BloodRequestView(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => BloodRequestController());
            },
          ),
        ),
        GetPage(
          name: AppRoutes.campaignsView,
          page: () => const CampaingsView(),
        ),
        GetPage(
          name: AppRoutes.splashView,
          page: () => const SplashView(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut(() => SplashController());
            },
          ),
        ),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
    );
  }
}

// listening to a background remote notifications
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
