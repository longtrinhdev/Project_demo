import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRoute {
  static void pushLeftToRight(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRight,
        child: widget,
      ),
    );
  }

  static void pushBottomToTop(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.bottomToTop,
        child: widget,
      ),
    );
  }

  static void pushReplacementLeftToRight(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.leftToRight,
        child: widget,
      ),
    );
  }

  static void pushReplacementBottomToTop(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.bottomToTop,
        child: widget,
      ),
    );
  }

  static void pushAndRemoveLeftToRight(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        type: PageTransitionType.leftToRight,
        child: widget,
      ),
      (route) => false,
    );
  }

  static void pushAndRemoveBottomToTop(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        type: PageTransitionType.bottomToTop,
        child: widget,
      ),
      (route) => false,
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
