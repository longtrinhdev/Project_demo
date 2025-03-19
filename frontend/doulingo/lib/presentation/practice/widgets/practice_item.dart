import 'package:doulingo/common/widget/item_view/item_view.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/presentation/practice/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PracticeItemWidget extends StatelessWidget {
  final SvgPicture picture;
  final String text;
  final String content;
  final VoidCallback callback;
  const PracticeItemWidget({
    super.key,
    required this.picture,
    required this.text,
    required this.content,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return ItemView(
      callback: callback,
      isSelected: false,
      title: Stack(
        children: [
          Positioned(
            top: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextViewShow(
                  text: text,
                  size: 20,
                  color: AppColors.textColor,
                  fw: FontWeight.w800,
                ),
                const SizedBox(
                  height: 4,
                ),
                TextViewShow(
                  text: content,
                  size: 18,
                  color: AppColors.textSecondColor,
                  fw: FontWeight.w600,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: picture,
          ),
        ],
      ),
    );
  }
}
