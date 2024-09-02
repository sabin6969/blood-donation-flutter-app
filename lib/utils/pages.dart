import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/controllers/blood_request_controller.dart';
import 'package:blood_donation_flutter_app/controllers/campaign_controller.dart';
import 'package:blood_donation_flutter_app/controllers/home_controller.dart';
import 'package:blood_donation_flutter_app/controllers/login_controller.dart';
import 'package:blood_donation_flutter_app/controllers/onboarding_controller.dart';
import 'package:blood_donation_flutter_app/controllers/register_controller.dart';
import 'package:blood_donation_flutter_app/controllers/search_donor_controller.dart';
import 'package:blood_donation_flutter_app/controllers/splash_controller.dart';
import 'package:blood_donation_flutter_app/views/auth/login_signup_view.dart';
import 'package:blood_donation_flutter_app/views/auth/login_view.dart';
import 'package:blood_donation_flutter_app/views/auth/register_view.dart';
import 'package:blood_donation_flutter_app/views/blood_request_view.dart';
import 'package:blood_donation_flutter_app/views/campaings/campaigns_view.dart';
import 'package:blood_donation_flutter_app/views/donors_view.dart';
import 'package:blood_donation_flutter_app/views/landing_view.dart';
import 'package:blood_donation_flutter_app/views/map/google_map_view.dart';
import 'package:blood_donation_flutter_app/views/no_internet_view.dart';
import 'package:blood_donation_flutter_app/views/onboarding_view.dart';
import 'package:blood_donation_flutter_app/views/splash_view.dart';
import 'package:blood_donation_flutter_app/views/user_specific/blood_request_status_view.dart';
import 'package:get/get.dart';

List<GetPage> pages = [
  GetPage(
    name: AppRoutes.onboardingView,
    page: () => const OnboardingView(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(
          () => OnboardingController(),
        );
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
        Get.lazyPut(
          () => LoginController(),
        );
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
    binding: BindingsBuilder(
      () {
        Get.lazyPut(
          () => HomeController(),
        );
      },
    ),
  ),
  GetPage(
    name: AppRoutes.donorsView,
    page: () => const DonorsView(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(
          () => SearchDonorController(),
        );
      },
    ),
  ),
  GetPage(
    name: AppRoutes.bloodRequestView,
    page: () => const BloodRequestView(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(
          () => BloodRequestController(),
        );
      },
    ),
  ),
  GetPage(
    name: AppRoutes.campaignsView,
    page: () => const CampaingsView(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(
          () => CampaingController(),
        );
      },
    ),
  ),
  GetPage(
    name: AppRoutes.splashView,
    page: () => const SplashView(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(
          () => SplashController(),
        );
      },
    ),
  ),
  GetPage(
    name: AppRoutes.gooleMapView,
    page: () => const GoogleMapView(),
  ),
  GetPage(
    name: AppRoutes.noInternetView,
    page: () => const NoInternetView(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(() => SplashController());
      },
    ),
  ),
  GetPage(
    name: AppRoutes.bloodRequestStatusView,
    page: () => const BloodRequestStatusView(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => BloodRequestController());
    }),
  )
];
