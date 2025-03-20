import 'package:doulingo/common/bloc/generate_data_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/failed_page/failed_page.dart';
import 'package:doulingo/common/widget/item_view/item_view.dart';
import 'package:doulingo/common/widget/loading/loading.dart';
import 'package:doulingo/core/config/assets/app_images.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/domain/chapter/entities/chapter.dart';
import 'package:doulingo/domain/chapter/use_case/get_all_chapter.dart';
import 'package:doulingo/presentation/lesson/pages/lesson_pages.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChaptersWidget extends StatelessWidget {
  final String courseId;
  final String courseTitle;
  const ChaptersWidget({
    super.key,
    required this.courseId,
    required this.courseTitle,
  });

  Widget _buildData(List<ChapterEntity> chapters, Size size) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: chapters.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      itemBuilder: (context, index) {
        final chapter = chapters[index];
        Color colorCode = Color(int.parse(chapter.color!));
        return ItemView(
          key: const ValueKey('item_chapter'),
          callback: () {
            AppRoute.pushBottomToTop(
              context,
              LessonPages(
                title: courseTitle,
                chapterId: chapter.id!,
                nameChapter: chapter.name!,
              ),
            );
          },
          isSelected: false,
          title: _itemChapter(chapter, colorCode, size),
        );
      },
    );
  }

  Widget _itemChapter(ChapterEntity chapter, Color color, Size size) {
    double value = (0 / 5);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: size.width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: SvgPicture.network(
            chapter.avatar!,
            width: 210,
            height: 210,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chapter.name!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textColor,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: size.width,
                    height: 20,
                    child: LinearProgressIndicator(
                      value: value,
                      borderRadius: BorderRadius.circular(16),
                      backgroundColor: AppColors.unselect,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.secondColor,
                      ),
                    ),
                  ),
                  (chapter.isUnlocked == true) ? _unlock(value) : _lock(),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _unlock(double value) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '3',
              style: TextStyle(
                fontSize: 18,
                color: (value * 10 > 5)
                    ? AppColors.background
                    : AppColors.textSecondColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: ' / ',
              style: TextStyle(
                fontSize: 18,
                color: (value * 10 > 5)
                    ? AppColors.background
                    : AppColors.textSecondColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: '5',
              style: TextStyle(
                fontSize: 18,
                color: (value * 10 > 5)
                    ? AppColors.background
                    : AppColors.textSecondColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lock() {
    return Image.asset(
      key: const ValueKey('img_lock'),
      AppImages.imgLock,
      color: AppColors.textSecondColor.withOpacity(.8),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => GenerateDataCubit()
        ..getData<List<ChapterEntity>>(sl<GetAllChapterUseCase>(),
            params: courseId),
      child: BlocBuilder<GenerateDataCubit, GenerateDataState>(
        builder: (context, state) {
          if (state is DataLoading) {
            return const AppLoading();
          }

          if (state is DataLoaded) {
            List<ChapterEntity> chapters = state.data;
            return _buildData(chapters, size);
          }
          return const FailedPage();
        },
      ),
    );
  }
}
