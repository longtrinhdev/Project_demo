import 'package:flutter/material.dart';

class AppRound extends StatelessWidget {
  final Color? backgroundColor;
  final Color? borderColor;
  final Widget? widget;
  const AppRound({
    super.key,
    this.backgroundColor,
    this.borderColor,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: borderColor!,
          width: 2,
        ),
      ),
      child: widget,
    );
  }
}
