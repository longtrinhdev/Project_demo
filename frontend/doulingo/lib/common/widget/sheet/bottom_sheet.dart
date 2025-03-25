import 'package:flutter/material.dart';

class AppBottomSheet {
  void showBottomSheet(BuildContext context, Color bg, Widget child) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(),
      backgroundColor: bg,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          padding: const EdgeInsets.all(16.0),
          child: child,
        );
      },
    );
  }
}
