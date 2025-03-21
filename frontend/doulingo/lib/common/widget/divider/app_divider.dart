import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.unselect,
      thickness: 1.5,
    );
  }
}
