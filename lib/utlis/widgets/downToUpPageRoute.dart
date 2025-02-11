import 'package:flutter/material.dart';

class DownToUpPageRoute extends PageRouteBuilder {
  final Widget widget;

  DownToUpPageRoute({required this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              widget,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(
                    0.0, 1.0), // Start position (off-screen at the bottom)
                end: Offset.zero, // End position (center of the screen)
              ).animate(animation),
              child: child,
            );
          },
        );
}
