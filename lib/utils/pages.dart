import 'package:blood_donation_flutter_app/controllers/banner_image/banner_image_controller.dart';
import 'package:blood_donation_flutter_app/core/routes/app_named_route.dart';
import 'package:blood_donation_flutter_app/controllers/blood_request_controller.dart';
import 'package:blood_donation_flutter_app/controllers/campaign_controller.dart';
import 'package:blood_donation_flutter_app/controllers/home_controller.dart';
import 'package:blood_donation_flutter_app/controllers/login_controller.dart';
import 'package:blood_donation_flutter_app/controllers/onboarding_controller.dart';
import 'package:blood_donation_flutter_app/controllers/register_controller.dart';
import 'package:blood_donation_flutter_app/controllers/search_donor_controller.dart';
import 'package:blood_donation_flutter_app/controllers/splash_controller.dart';
import 'package:blood_donation_flutter_app/repository/banner_image/banner_image_repository.dart';
import 'package:blood_donation_flutter_app/views/auth/login_signup_view.dart';
import 'package:blood_donation_flutter_app/views/auth/login_view.dart';
import 'package:blood_donation_flutter_app/views/auth/register_view.dart';
import 'package:blood_donation_flutter_app/views/blood_request_view.dart';
import 'package:blood_donation_flutter_app/views/campaings/campaigns_view.dart';
import 'package:blood_donation_flutter_app/views/donor/donors_view.dart';
import 'package:blood_donation_flutter_app/views/donor/nearby_donor_view.dart';
import 'package:blood_donation_flutter_app/views/landing/landing_view.dart';
import 'package:blood_donation_flutter_app/views/map/google_map_view.dart';
import 'package:blood_donation_flutter_app/views/notifications/notifications_configuration_view.dart';
import 'package:blood_donation_flutter_app/views/onboarding_view.dart';
import 'package:blood_donation_flutter_app/views/splash/splash_view.dart';
import 'package:blood_donation_flutter_app/views/user_specific/blood_request_status_view.dart';
import 'package:get/get.dart';

List<GetPage> pages = [
  GetPage(
    name: AppNamedRoute.onboardingView,
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
    name: AppNamedRoute.loginSignupView,
    page: () => const LoginSignupView(),
  ),
  GetPage(
    name: AppNamedRoute.loginView,
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
    name: AppNamedRoute.signupView,
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
    name: AppNamedRoute.landingView,
    page: () => const LandingView(),
    binding: BindingsBuilder(
      () {
        Get.lazyPut(
          () => HomeController(),
        );
        Get.lazyPut(
          () => BannerImageController(
            bannerImageRepository: BannerImageRepository(),
          ),
        );
      },
    ),
  ),
  GetPage(
    name: AppNamedRoute.donorsView,
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
    name: AppNamedRoute.bloodRequestView,
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
    name: AppNamedRoute.campaignsView,
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
    name: AppNamedRoute.splashView,
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
    name: AppNamedRoute.googleMapView,
    page: () => const GoogleMapView(),
  ),
  GetPage(
    name: AppNamedRoute.bloodRequestStatusView,
    page: () => const BloodRequestStatusView(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => BloodRequestController());
    }),
  ),
  GetPage(
    name: AppNamedRoute.nearbyDonorView,
    page: () => const NearbyDonorView(),
  ),
  GetPage(
    name: AppNamedRoute.notificationConfigurationView,
    page: () => const NotificationsConfigurationView(),
  ),
];
