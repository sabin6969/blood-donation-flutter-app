import 'package:blood_donation_flutter_app/main.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool? isObsecure;
  final Widget? suffixIconButton;
  final String? Function(String?)? validator;
  final TextCapitalization? textCapitalization;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    required this.textInputType,
    this.isObsecure,
    this.suffixIconButton,
    this.textCapitalization,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return TextFormField(
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      validator: validator,
      obscureText: isObsecure ?? false,
      keyboardType: textInputType,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIconButton,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            size.width * 0.03,
          ),
        ),
      ),
    );
  }
}
