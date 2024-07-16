import 'package:blood_donation_flutter_app/main.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  const CustomTextField(
      {super.key, required this.hintText, required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return TextFormField(
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
