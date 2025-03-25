import 'package:doulingo/common/bloc/generate_data_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/failed_page/failed_page.dart';
import 'package:doulingo/common/widget/loading/animation_loading.dart';
import 'package:doulingo/common/widget/sheet/bottom_sheet.dart';
import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/domain/question/entity/question.dart';
import 'package:doulingo/domain/question/use_case/get_all_question_uc.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LessonPage extends StatefulWidget {
  final String sectionId;
  final String lessonId;
  const LessonPage({
    super.key,
    required this.sectionId,
    required this.lessonId,
  });

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  double value = 1 / 5;
  bool checkResult = true;

  Widget _loading() {
    return const AnimationLoading();
  }

  Widget _success() {
    return Scaffold(
      appBar: _appBar(),
      bottomSheet: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: _backgroundSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GenerateDataCubit>(
      create: (context) => GenerateDataCubit()
        ..getData<List<QuestionEntity>>(
          sl<GetAllQuestionUc>(),
          params: [widget.sectionId, widget.lessonId],
        ),
      child: BlocListener<GenerateDataCubit, GenerateDataState>(
        listener: (context, state) {},
        child: BlocBuilder<GenerateDataCubit, GenerateDataState>(
          builder: (context, state) {
            if (state is DataLoading) {
              return _loading();
            } else if (state is DataLoaded) {
              return _success();
            }
            return const FailedPage();
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      leading: IconButton(
        onPressed: (value == 0.0)
            ? () {
                AppRoute.pop(context);
              }
            : () {
                AppBottomSheet().showBottomSheet(
                  context,
                  AppColors.background,
                  _bottomSheet(),
                );
              },
        icon: const Icon(
          Icons.close_rounded,
          color: AppColors.textSecondColor,
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              backgroundColor: AppColors.textSecondColor.withOpacity(.5),
              borderRadius: BorderRadius.circular(16),
              value: value,
              minHeight: 15,
              valueColor: const AlwaysStoppedAnimation(
                AppColors.secondColor,
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          SvgPicture.asset(AppVectors.icHeart),
          const SizedBox(
            width: 4,
          ),
          const TextViewShow(
            text: '3',
            size: 24,
            color: AppColors.colorHeart,
            fw: FontWeight.w800,
          ),
        ],
      ),
    );
  }

  Widget _bottomSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 16,
        ),
        SvgPicture.asset(AppVectors.icCry),
        const SizedBox(
          height: 16,
        ),
        const TextViewShow(
          text: AppTexts.tvExistLearnTitle,
          size: 20,
          isCenter: true,
          color: AppColors.textColor,
          fw: FontWeight.w900,
        ),
        const Spacer(),
        BaseButton(
          onPressed: () {
            AppRoute.pop(context);
          },
          backgroundColor: AppColors.textThirdColor,
          checkBorder: true,
          widget: TextViewShow(
            text: AppTexts.btnContinueLearn.toUpperCase(),
            size: 18,
            color: AppColors.background,
            fw: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        BaseButton(
          onPressed: () {
            AppRoute.pop(context);
            AppRoute.pop(context);
          },
          backgroundColor: AppColors.background,
          widget: TextViewShow(
            text: AppTexts.btnStopLearn.toUpperCase(),
            size: 18,
            color: AppColors.textThirdColor,
            fw: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buttonCheck() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextViewShow(
            text: AppTexts.tvSuccess,
            size: 24,
            color: AppColors.textSuccess,
            fw: FontWeight.w900,
          ),
          const SizedBox(
            height: 20,
          ),
          BaseButton(
            onPressed: () {},
            backgroundColor: AppColors.secondColor,
            checkBorder: true,
            widget: TextViewShow(
              text: AppTexts.btnCheck.toUpperCase(),
              size: 18,
              color: AppColors.background,
              fw: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _backgroundSheet() {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: (checkResult == true)
              ? AppColors.primaryColor.withOpacity(.5)
              : AppColors.background,
        ),
        Align(
          alignment: Alignment.center,
          child: _buttonCheck(),
        ),
      ],
    );
  }
}
