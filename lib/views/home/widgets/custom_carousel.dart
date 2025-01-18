import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class CustomCarousel extends StatefulWidget {
  final List<String> imagePaths;
  const CustomCarousel({
    super.key,
    required this.imagePaths,
  });

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();

    Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        if (_pageController.hasClients) {
          _pageController.page?.round() == (widget.imagePaths.length - 1)
              ? _pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                )
              : _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
        } else {
          timer.cancel();
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.imagePaths.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                widget.imagePaths[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
