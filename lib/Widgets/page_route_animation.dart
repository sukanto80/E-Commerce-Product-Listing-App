import 'package:flutter/material.dart';

enum PageTransitionType {
  fade,
  slideFromRight,
  slideFromLeft,
  slideFromBottom,
  scale,
  rotation,
}

PageRouteBuilder animatedRoute({
  required Widget page,
  PageTransitionType transitionType = PageTransitionType.fade,
  Duration duration = const Duration(milliseconds: 700),
}) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionDuration: duration,
    transitionsBuilder: (_, animation, __, child) {
      switch (transitionType) {
        case PageTransitionType.fade:
          return FadeTransition(opacity: animation, child: child);

        case PageTransitionType.slideFromRight:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );

        case PageTransitionType.slideFromLeft:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );

        case PageTransitionType.slideFromBottom:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );

        case PageTransitionType.scale:
          return ScaleTransition(
            scale: Tween<double>(
              begin: 0.8,
              end: 1.0,
            ).animate(animation),
            child: child,
          );

        case PageTransitionType.rotation:
          return RotationTransition(
            turns: Tween<double>(
              begin: 0.5,
              end: 1.0,
            ).animate(animation),
            child: child,
          );

        default:
          return child;
      }
    },
  );
}
