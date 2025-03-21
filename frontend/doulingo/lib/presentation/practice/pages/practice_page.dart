import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/practice/widgets/bounce_item.dart';
import 'package:doulingo/presentation/practice/widgets/practice_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PracticePage extends StatelessWidget {
  const PracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 1.5,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            const TextViewShow(
              text: AppTexts.tvPracticeTitle,
              size: 24,
              color: AppColors.textColor,
              fw: FontWeight.w900,
            ),
            const SizedBox(
              height: 24,
            ),
            const BounceItemWidget(),
            const SizedBox(
              height: 32,
            ),
            const TextViewShow(
              text: AppTexts.tvCommunication,
              size: 24,
              color: AppColors.textColor,
              fw: FontWeight.w800,
            ),
            const SizedBox(
              height: 32,
            ),
            PracticeItemWidget(
              picture: SvgPicture.asset(AppVectors.icVoice),
              text: AppTexts.tvSpeaking,
              content: AppTexts.tvSpeakingContent,
              callback: () {},
            ),
            const SizedBox(
              height: 16,
            ),
            PracticeItemWidget(
              picture: SvgPicture.asset(AppVectors.icListening),
              text: AppTexts.tvListening,
              content: AppTexts.tvListeningContent,
              callback: () {},
            ),
            const SizedBox(
              height: 32,
            ),
            const TextViewShow(
              text: AppTexts.tvPractice,
              size: 24,
              color: AppColors.textColor,
              fw: FontWeight.w800,
            ),
            const SizedBox(
              height: 16,
            ),
            PracticeItemWidget(
              picture: SvgPicture.asset(AppVectors.icGrammar),
              text: AppTexts.tvGrammar,
              content: AppTexts.tvGrammarContent,
              callback: () {},
            ),
            const SizedBox(
              height: 16,
            ),
            PracticeItemWidget(
              picture: SvgPicture.asset(AppVectors.icVocab),
              text: AppTexts.tvVocab,
              content: AppTexts.tvVocabContent,
              callback: () {},
            ),
            const SizedBox(
              height: 16,
            ),
            PracticeItemWidget(
              picture: SvgPicture.asset(AppVectors.icBook),
              text: AppTexts.tvReading,
              content: AppTexts.tvReadingContent,
              callback: () {},
            ),
          ],
        ),
      ),
    );
  }
}
