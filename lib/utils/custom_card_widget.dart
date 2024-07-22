import 'package:blood_donation_flutter_app/main.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String imageIconPath;
  final void Function()? onTap;
  const CustomCard({
    super.key,
    required this.title,
    required this.imageIconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: onTap,
      child: Ink(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageIconPath),
            const SizedBox(
              height: 10,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
