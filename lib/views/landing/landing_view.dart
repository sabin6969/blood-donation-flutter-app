import './widgets/animated_icon.dart';

import 'package:blood_donation_flutter_app/utils/ask_for_notifications.dart';
import 'package:blood_donation_flutter_app/utils/handle_on_exit.dart';
import 'package:blood_donation_flutter_app/views/home_view.dart';
import 'package:blood_donation_flutter_app/views/user_specific/profile_view.dart';
import 'package:blood_donation_flutter_app/views/admins_view.dart';
import 'package:flutter/material.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => HomeViewState();
}

class HomeViewState extends State<LandingView> {
  final ValueNotifier<int> _currentIndexVN = ValueNotifier<int>(0);

  List<Widget> pages = [
    const HomeView(),
    const AdminsView(),
    const ProfileView(),
  ];

  void askPermissionForNotification() {
    askForNotification();
  }

  @override
  void initState() {
    super.initState();
    askPermissionForNotification();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          handleOnAppExit(context: context);
        }
      },
      canPop: false,
      child: Scaffold(
          body: ValueListenableBuilder(
            valueListenable: _currentIndexVN,
            builder: (context, value, child) {
              return pages[value];
            },
          ),
          bottomNavigationBar: ValueListenableBuilder(
            valueListenable: _currentIndexVN,
            builder: (context, value, child) {
              return BottomNavigationBar(
                onTap: (index) {
                  _currentIndexVN.value = index;
                },
                items: [
                  BottomNavigationBarItem(
                    icon: AnimatedBottomNavBarIcon(
                      currentIndex: value,
                      activationIndex: 0,
                      child: const Icon(
                        Icons.home_outlined,
                      ),
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: AnimatedBottomNavBarIcon(
                      currentIndex: value,
                      activationIndex: 1,
                      child: const Icon(
                        Icons.admin_panel_settings_outlined,
                      ),
                    ),
                    label: "Admins",
                  ),
                  BottomNavigationBarItem(
                    icon: AnimatedBottomNavBarIcon(
                      currentIndex: value,
                      activationIndex: 2,
                      child: const Icon(
                        Icons.person_2_outlined,
                      ),
                    ),
                    label: "Profile",
                  )
                ],
              );
            },
          )),
    );
  }
}
