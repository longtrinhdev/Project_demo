import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRoute {
  static void push(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: widget,
      ),
    );
  }

  static void pushReplacement(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: widget,
      ),
    );
  }

  static void pushAndRemove(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: widget,
      ),
      (route) => false,
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
