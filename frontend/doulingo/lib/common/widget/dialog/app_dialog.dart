import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppDialog {
  void showDialogApp(
      BuildContext context, Widget header, Widget body, Widget footer) {
    showDialog(
      context: context,
      builder: (context) {
        final size = MediaQuery.of(context).size.width;
        return Dialog(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _header(header, size),
              const SizedBox(
                height: 24,
              ),
              body,
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: footer,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _header(Widget header, double width) {
    return Container(
      width: width,
      height: 64,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: AppColors.textThirdColor,
      ),
      child: header,
    );
  }
}
