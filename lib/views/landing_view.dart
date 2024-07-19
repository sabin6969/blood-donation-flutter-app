import 'package:blood_donation_flutter_app/views/home_view.dart';
import 'package:blood_donation_flutter_app/views/profile_view.dart';
import 'package:blood_donation_flutter_app/views/search_view.dart';
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
    const SearchView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: Icon(Icons.search_outlined),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Profile",
          )
        ],
      ),
    );
  }
}
