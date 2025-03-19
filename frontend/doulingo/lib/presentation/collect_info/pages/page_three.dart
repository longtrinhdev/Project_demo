import 'dart:developer';

import 'package:doulingo/common/bloc/generate_data_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/common/helpers/mapper/shared_req.dart';
import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/local_data/use_case/set_data_use_case.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/item_view/item_view.dart';
import 'package:doulingo/common/widget/tool_tip/app_tooltip.dart';
import 'package:doulingo/core/config/assets/app_images.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/domain/languages/entities/language.dart';
import 'package:doulingo/domain/languages/usecase/get_all_language.dart';
import 'package:doulingo/presentation/collect_info/pages/page_four.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseLanguage extends StatefulWidget {
  final String? userId;
  const ChooseLanguage({
    super.key,
    this.userId,
  });

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  int? indexSelected;

  PreferredSizeWidget _appBar(Size size) {
    return AppbarBase(
      backgroundColor: AppColors.background,
      checkIcon: true,
      action: SizedBox(
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              width: 8,
            ),
            SizedBox(
              width: size.width - 80,
              height: 15,
              child: LinearProgressIndicator(
                value: 0.3,
                borderRadius: BorderRadius.circular(16),
                backgroundColor: AppColors.unselect,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.secondColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button(LanguageEntity language) {
    return BaseButton(
      onPressed: () async {
        await sl<SetDataUseCase>().call(
          params: SharedReq(key: 'language', value: language.id!),
        );
        log('Id: ${language.id}');
        if (indexSelected != null && mounted) {
          AppRoute.pushLeftToRight(
            context,
            PageFour(
              progress: 0.6,
              userId: widget.userId,
            ),
          );
        }
      },
      backgroundColor:
          (indexSelected == null) ? AppColors.unselect : AppColors.secondColor,
      checkBorder: (indexSelected == null) ? false : true,
      widget: Text(
        AppTexts.tvContinue.toUpperCase(),
        style: TextStyle(
          fontSize: 18,
          color: (indexSelected == null)
              ? AppColors.textSecondColor
              : AppColors.background,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _textTitle(double width) {
    return SizedBox(
      width: width,
      child: const Text(
        textAlign: TextAlign.start,
        AppTexts.chooseLanguagePageTitle,
        style: TextStyle(
          fontSize: 18,
          color: AppColors.textColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _itemLanguage(LanguageEntity language, bool selected) {
    return ItemView(
      isSelected: selected,
      leading: SvgPicture.network(
        language.image!,
        width: 36,
        height: 36,
      ),
      title: Text(
        language.language!,
        style: const TextStyle(
          fontSize: 18,
          color: AppColors.textColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => GenerateDataCubit()
        ..getData<List<LanguageEntity>>(sl<GetAllLanguageUseCase>()),
      child: BlocBuilder<GenerateDataCubit, GenerateDataState>(
        builder: (context, state) {
          if (state is DataLoading) {
            return const Center(
              child: SpinKitThreeBounce(
                color: AppColors.textSecondColor,
                size: 36.0,
              ),
            );
          }

          if (state is DataLoaded) {
            final language = state.data[indexSelected ?? 0];
            return Scaffold(
              appBar: _appBar(size),
              body: Container(
                width: size.width,
                height: size.height,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    AppTooltip(
                      message: AppTexts.tvContentLanguage,
                      widget: Image.asset(
                        AppImages.imgIntro,
                      ),
                      arrowDirection: true,
                      distanceLeft: size.width / 4 + 20,
                      distanceTop: 30,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    _textTitle(size.width),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: state.data.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 12,
                        ),
                        itemBuilder: (context, index) {
                          final language = state.data[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                indexSelected = index;
                              });
                            },
                            child:
                                _itemLanguage(language, index == indexSelected),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _button(language),
              ),
            );
          }

          if (state is DataLoadedFailure) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
