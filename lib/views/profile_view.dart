import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Profile Page"),
    );
  }
}
