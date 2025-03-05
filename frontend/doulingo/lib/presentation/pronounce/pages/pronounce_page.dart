import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PronouncePage extends StatelessWidget {
  const PronouncePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Pronounce',
          style: TextStyle(color: AppColors.textColor),
        ),
      ),
    );
  }
}
