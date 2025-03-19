import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show(
    BuildContext context,
    String? url,
    String? message,
    Color? textColor,
  ) {
    SnackBar snackBar = SnackBar(
      content: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              url!,
              width: 24,
              height: 24,
            ),
            Text(
              message!,
              style: TextStyle(
                fontSize: 18,
                color: textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              icon: const Icon(
                Icons.close_rounded,
                color: AppColors.background,
              ),
            ),
          ],
        ),
      ),
      elevation: 0,
      dismissDirection: DismissDirection.down,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
