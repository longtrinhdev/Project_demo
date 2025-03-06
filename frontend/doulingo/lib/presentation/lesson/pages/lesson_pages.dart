import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/lesson/widgets/road_map_chapter.dart';
import 'package:flutter/material.dart';

class LessonPages extends StatefulWidget {
  final String title;
  final String chapterId;
  const LessonPages({
    super.key,
    required this.title,
    required this.chapterId,
  });

  @override
  State<LessonPages> createState() => _LessonPagesState();
}

class _LessonPagesState extends State<LessonPages> {
  PreferredSizeWidget _appBar() {
    return AppbarBase(
      backgroundColor: AppColors.background,
      title: Text(
        '${AppTexts.tvLessonTitle}${widget.title}',
        style: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w900,
          color: AppColors.textColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: RoadMapChapter(
        chapterId: widget.chapterId,
      ),
    );
  }
}
