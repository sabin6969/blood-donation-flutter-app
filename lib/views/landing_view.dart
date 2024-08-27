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
  int currentIndex = 0;
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
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shield),
              label: "Admins",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: "Profile",
            )
          ],
        ),
      ),
    );
  }
}
