import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:flutter/material.dart';

class SearchFriend extends StatelessWidget {
  const SearchFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: _textResult(),
          ),
        ],
      ),
    );
  }

  _textResult() {
    return const TextViewShow(
      text: AppTexts.tvSearchResult,
      size: 22,
      color: AppColors.textColor,
      fw: FontWeight.w900,
    );
  }
}
