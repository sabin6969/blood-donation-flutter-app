import 'package:blood_donation_flutter_app/main.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final TextEditingController controller;
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            size.width * 0.02,
          ),
        ),
      ),
    );
  }
}
