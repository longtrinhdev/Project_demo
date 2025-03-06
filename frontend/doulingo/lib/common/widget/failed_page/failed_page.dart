import 'package:doulingo/common/widget/tool_tip/app_tooltip.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FailedPage extends StatelessWidget {
  const FailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.secondBackground,
      child: Center(
        child: AppTooltip(
          message: AppTexts.tvLoadFailedTitle,
          widget: SvgPicture.asset(
            AppVectors.icLoadFailed,
            width: 120,
            height: 120,
          ),
          distanceLeft: size.width / 3 - 10,
          distanceTop: size.height / 3 - 20,
        ),
      ),
    );
  }
}
