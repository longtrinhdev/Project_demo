import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondBackground,
      child: Center(
        child: SpinKitThreeBounce(
          color: AppColors.textSecondColor.withOpacity(.5),
          size: 32,
        ),
      ),
    );
  }
}
