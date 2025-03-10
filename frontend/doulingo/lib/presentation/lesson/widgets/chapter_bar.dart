import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/config/theme/border_color.dart';
import 'package:doulingo/domain/section/entities/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChapterBar extends StatelessWidget {
  final SectionEntity data;
  final String nameChapter;
  const ChapterBar({
    super.key,
    required this.data,
    required this.nameChapter,
  });

  Widget _chapterTitle() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$nameChapter, ${data.name}'.toUpperCase(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.unselect,
              ),
            ),
            Text(
              data.title!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.background,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentSection(Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: borderColor(color, .1),
            width: 2,
          ),
        ),
      ),
      child: SvgPicture.asset(AppVectors.icList),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color color = Color(int.parse(data.color!));
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.0),
        border: Border(
          bottom: BorderSide(
            color: borderColor(color, .1),
            width: 4,
          ),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _chapterTitle(),
            _contentSection(color),
          ],
        ),
      ),
    );
  }
}
