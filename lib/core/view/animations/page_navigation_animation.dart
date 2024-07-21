import 'package:flutter/material.dart';

class PageNavigationAnimation<T> extends PageRouteBuilder<T> {
  final Widget page;

  PageNavigationAnimation({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: const Duration(milliseconds: 900),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Customize the animation here, e.g., FadeTransition
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(
                      1.0, 0.0), // Start from the right screen edge
                  end: const Offset(0.0, 0.0), // Slide to the left
                ).animate(animation),
                child: child,
              ),
            );
          },
        );
}
