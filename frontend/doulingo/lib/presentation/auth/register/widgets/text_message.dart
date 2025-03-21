import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  final String message;
  const TextMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextViewShow(
          text: message,
          size: 20,
          color: Colors.red,
          fw: FontWeight.bold,
        ),
      ],
    );
  }
}
