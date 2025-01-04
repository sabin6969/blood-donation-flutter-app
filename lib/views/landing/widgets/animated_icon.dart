import 'package:flutter/material.dart';

class AnimatedBottomNavBarIcon extends StatelessWidget {
  final int currentIndex;
  final int activationIndex;
  final Icon child;
  const AnimatedBottomNavBarIcon({
    super.key,
    required this.currentIndex,
    required this.activationIndex,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 300,
      ),
      width: 50,
      padding: const EdgeInsets.symmetric(
        vertical: 1,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: currentIndex == activationIndex
              ? const BorderSide(
                  color: Colors.purple,
                  width: 3,
                )
              : BorderSide.none,
        ),
      ),
      child: child,
    );
  }
}
