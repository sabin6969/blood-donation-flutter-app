import 'package:blood_donation_flutter_app/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void handleOnAppExit({required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Image.asset(
        ImagePath.appExitImage,
        height: 50,
        width: 50,
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Are you sure you want to exit?"),
        ],
      ),
      titlePadding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 20,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
          ),
        ),
        TextButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          child: const Text(
            "Exit",
          ),
        )
      ],
    ),
  );
}
