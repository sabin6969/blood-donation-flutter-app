import 'package:blood_donation_flutter_app/main.dart';
import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  final String buttonName;
  final Color? buttonColor;
  final Color textColor;
  final void Function()? onPressed;
  const CustomAuthButton({
    super.key,
    required this.buttonName,
    this.buttonColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return MaterialButton(
      minWidth: size.width,
      height: size.height * 0.06,
      color: buttonColor,
      shape: const StadiumBorder(),
      onPressed: onPressed,
      child: Text(
        buttonName,
        style: TextStyle(
          fontSize: 16,
          color: textColor,
        ),
      ),
    );
  }
}
