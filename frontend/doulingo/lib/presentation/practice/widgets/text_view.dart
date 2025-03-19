import 'package:flutter/material.dart';

class TextViewShow extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fw;
  const TextViewShow({
    super.key,
    required this.text,
    required this.size,
    required this.color,
    required this.fw,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fw,
      ),
    );
  }
}
