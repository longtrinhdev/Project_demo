import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class RankHeaderWidget extends StatelessWidget {
  const RankHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _imgLevel(AppVectors.icRuby, 54),
            _imgLevel(AppVectors.icSilver, 54),
            _imgLevel(AppVectors.icRankNow, 96),
            _imgLevel(AppVectors.icSilver, 54),
            _imgLevel(AppVectors.icRuby, 54),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        _text(
          AppTexts.tvRankPageTitle,
          28,
          FontWeight.w900,
          AppColors.textColor,
        ),
        const SizedBox(
          height: 12,
        ),
        _text(
          AppTexts.tvRankPageContent,
          18,
          FontWeight.w800,
          AppColors.textSecondColor,
        ),
      ],
    );
  }

  Widget _imgLevel(String assetName, double width) {
    return SvgPicture.asset(
      assetName,
      width: width,
      fit: BoxFit.cover,
    );
  }

  Widget _text(String message, double size, FontWeight fw, Color color) {
    return Text(
      message,
      style: TextStyle(
        fontSize: size,
        fontWeight: fw,
        color: color,
      ),
    );
  }
}
