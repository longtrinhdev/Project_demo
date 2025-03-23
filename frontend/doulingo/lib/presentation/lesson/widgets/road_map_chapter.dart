import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/config/theme/border_color.dart';
import 'package:doulingo/domain/section/entities/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoadMapChapter extends StatelessWidget {
  final SectionEntity data;
  const RoadMapChapter({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Color(int.parse(data.color!));
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Divider(
                    color: AppColors.textSecondColor,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                TextViewShow(
                  text: data.title!,
                  size: 20,
                  color: AppColors.textSecondColor,
                  fw: FontWeight.w800,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Expanded(
                  child: Divider(
                    color: AppColors.textSecondColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            ...List.generate(
              data.lessons!.length,
              (index) => Container(
                margin: EdgeInsets.only(
                  bottom: (index != 8) ? 24 : 16.0,
                  left: _marginLeft(index),
                  right: _marginRight(index),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36.0),
                  border: Border(
                    bottom: BorderSide(
                      width: 6,
                      color: borderColor(
                          (data.lessons![index].isUnlocked == true)
                              ? color
                              : AppColors.textSecondColor,
                          .1),
                    ),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (data.lessons![index].isUnlocked == true)
                        ? color
                        : AppColors.unselect,
                    alignment: Alignment.center,
                    elevation: 0,
                    fixedSize: const Size(64, 54),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                  ),
                  child: SvgPicture.asset(
                    AppVectors.icStar,
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 32,
          top: size.height / 5,
          child: SvgPicture.network(
            data.image!,
            width: 164,
            height: 164,
          ),
        ),
      ],
    );
  }

  double _marginLeft(int index) {
    int pos = index % 9;
    double margin = 72.0;
    if (pos == 1) {
      return margin;
    } else if (pos == 2) {
      return margin * 2;
    } else if (pos == 3) {
      return margin;
    } else {
      return 0.0;
    }
  }

  double _marginRight(int index) {
    int pos = index % 9;
    double margin = 72.0;
    if (pos == 5) {
      return margin;
    } else if (pos == 6) {
      return margin * 2;
    } else if (pos == 7) {
      return margin;
    } else {
      return 0.0;
    }
  }
}
