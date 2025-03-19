import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/snack_bar/custom_snackbar.dart';
import 'package:doulingo/common/widget/tool_tip/app_tooltip.dart';
import 'package:doulingo/core/config/assets/app_images.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';
import 'package:doulingo/domain/auth/entities/user.dart';
import 'package:doulingo/domain/auth/use_case/update_new_course.dart';
import 'package:doulingo/presentation/auth/register/pages/enter_email_page.dart';
import 'package:doulingo/presentation/introduce/introduce_page.dart';
import 'package:doulingo/presentation/main/pages/main_page.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';

class CreateProfile extends StatefulWidget {
  final String? userId;
  const CreateProfile({
    super.key,
    this.userId,
  });

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  late String title;

  @override
  void initState() {
    super.initState();
    title = (widget.userId == null)
        ? AppTexts.btnCreateFilePage
        : AppTexts.btnRouteToMain;
  }

  PreferredSizeWidget _appbar() {
    return const AppbarBase(
      backgroundColor: AppColors.background,
      hideBack: true,
    );
  }

  Widget _body(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: AppTooltip(
          message: (widget.userId == null)
              ? AppTexts.tvCreateProfileTitle
              : AppTexts.tvLeanNow,
          widget: Image.asset(AppImages.imgIntro),
          distanceLeft: size.width / 4 - 20,
          distanceTop: size.height / 4 - 36,
        ),
      ),
    );
  }

  Widget _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseButton(
            onPressed: (widget.userId == null)
                ? () {
                    AppRoute.pushBottomToTop(
                      context,
                      const EnterEmailPage(),
                    );
                  }
                : () async {
                    final courseId = await _getValueByKey('language');
                    final bio = await _getValueByKey('bio');
                    final userId = widget.userId!;

                    final responseData = await sl<UpdateNewCourseUC>().call(
                      params: SignupModel(
                        id: userId,
                        bio: bio,
                        courseId: courseId,
                      ),
                    );

                    responseData.fold(
                      (error) {
                        return _showSnackBar(context, error);
                      },
                      (data) {
                        final user = data as UserEntity;
                        AppRoute.pushAndRemoveLeftToRight(
                          context,
                          MainPage(
                            score: user.score,
                            courseId: courseId,
                            learnDays: user.learnDays ?? [],
                          ),
                        );
                        return;
                      },
                    );
                  },
            backgroundColor: AppColors.textThirdColor,
            checkBorder: true,
            widget: Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.background,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          (widget.userId == null)
              ? GestureDetector(
                  onTap: () {
                    AppRoute.pushAndRemoveBottomToTop(
                      context,
                      const IntroducePage(),
                    );
                  },
                  child: Text(
                    AppTexts.btnDifference.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textThirdColor,
                    ),
                  ),
                )
              : const SizedBox(
                  height: 10,
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appbar(),
      body: _body(size),
      bottomNavigationBar: _button(context),
    );
  }

  Future<String> _getValueByKey(String key) async {
    final courseId = await sl<GetDataUseCase>().call(
      params: key,
    );
    return courseId;
  }

  _showSnackBar(BuildContext context, String message) {
    return CustomSnackbar.show(
      context,
      AppImages.imgCancel,
      message,
      AppColors.background,
    );
  }
}
