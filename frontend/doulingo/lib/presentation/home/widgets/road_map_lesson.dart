import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoadMapLesson extends StatefulWidget {
  final Size size;
  const RoadMapLesson({
    super.key,
    required this.size,
  });

  @override
  State<RoadMapLesson> createState() => _RoadMapLessonState();
}

class _RoadMapLessonState extends State<RoadMapLesson> {
  Widget _statusBar(Size size) {
    return BaseButton(
      onPressed: () {},
      backgroundColor: const Color(0xffFE951F),
      checkBorder: true,
      height: 72,
      widget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'CHƯƠNG 2',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.secondBackground,
                  ),
                ),
                Text(
                  'Mua sắm ở cửa hàng',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: AppColors.background,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: 2,
              color: AppColors.textColor.withOpacity(.3),
            ),
            const SizedBox(
              width: 12,
            ),
            SvgPicture.asset(
              AppVectors.icList,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.unselect,
        ),
        _statusBar(widget.size)
      ],
    );
  }
}
