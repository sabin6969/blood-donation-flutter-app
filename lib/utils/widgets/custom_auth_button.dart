import 'package:blood_donation_flutter_app/main.dart';
import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  final Color? buttonColor;
  final void Function()? onPressed;
  final Widget child;
  const CustomAuthButton(
      {super.key,
      this.buttonColor,
      required this.onPressed,
      required this.child});

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return MaterialButton(
      minWidth: size.width,
      height: size.height * 0.07,
      color: buttonColor,
      shape: const StadiumBorder(),
      onPressed: onPressed,
      child: child,
    );
  }
}
