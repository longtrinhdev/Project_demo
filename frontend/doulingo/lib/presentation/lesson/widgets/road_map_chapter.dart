import 'package:doulingo/common/bloc/generate_data_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/failed_page/failed_page.dart';
import 'package:doulingo/common/widget/loading/loading.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/domain/chapter/entities/chapter.dart';
import 'package:doulingo/domain/chapter/use_case/get_chapter_by_id.dart';
import 'package:doulingo/presentation/Q&A/pages/question_answer_page.dart';
import 'package:doulingo/presentation/lesson/widgets/circle_button.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RoadMapChapter extends StatelessWidget {
  final String chapterId;
  const RoadMapChapter({
    super.key,
    required this.chapterId,
  });

  Widget _header(String title, String chapterName, Color color) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BaseButton(
        onPressed: () {},
        height: 80,
        checkBorder: true,
        backgroundColor: color,
        widget: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    chapterName.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.secondBackground,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: AppColors.background,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: 1.5,
              color: AppColors.textColor.withOpacity(.4),
            ),
            const SizedBox(
              width: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SvgPicture.asset(AppVectors.icList),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context, Size size, ChapterEntity chapter) {
    final title = chapter.title!;
    final chapterName = chapter.name!;
    double distanceTop = 100.0;
    Color color = Color(int.parse(chapter.color!));
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Positioned(
            top: distanceTop,
            left: 0,
            right: 0,
            child: _lessonSections(context, size, title, color),
          ),
          _header(title, chapterName, color),
        ],
      ),
    );
  }

  Widget _lessonSections(
      BuildContext context, Size size, String title, Color color) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: _section(context, title, color, size),
    );
  }

  Widget _section(BuildContext context, String title, Color color, Size size) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
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
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: AppColors.textSecondColor,
                fontWeight: FontWeight.w800,
              ),
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
        ...List.generate(
          9,
          (index) => CircleButton(
            image: (index % 2 == 0) ? AppVectors.icStar : AppVectors.icBook,
            callback: () {
              AppRoute.pushBottomToTop(
                context,
                const QuestionAnswerPage(),
              );
            },
            color: (index != 0) ? AppColors.textSecondColor : color,
            index: index,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => GenerateDataCubit()
        ..getData<ChapterEntity>(sl<GetChapterById>(), params: chapterId),
      child: BlocBuilder<GenerateDataCubit, GenerateDataState>(
        builder: (context, state) {
          if (state is DataLoading) {
            return const AppLoading();
          }
          if (state is DataLoaded) {
            ChapterEntity chapter = state.data;
            return _body(context, size, chapter);
          }
          return const FailedPage();
        },
      ),
    );
  }
}
