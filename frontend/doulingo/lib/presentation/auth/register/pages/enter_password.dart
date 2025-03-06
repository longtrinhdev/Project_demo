import 'dart:developer';

import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';
import 'package:doulingo/domain/auth/use_case/signup_use_case.dart';
import 'package:doulingo/presentation/auth/register/pages/signup_success_page.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EnterPasswordPage extends StatefulWidget {
  final String name;
  final String email;
  const EnterPasswordPage({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  State<EnterPasswordPage> createState() => _EnterPasswordPageState();
}

class _EnterPasswordPageState extends State<EnterPasswordPage> {
  final TextEditingController _controllerPassword = TextEditingController();
  bool? checkButton;
  bool isHide = true;
  String courseId = '';
  String bio = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerPassword.dispose();
  }

  Future<String> _getValueByKey(String key) async {
    final courseId = await sl<GetDataUseCase>().call(
      params: key,
    );
    return courseId;
  }

  PreferredSizeWidget _appBar(Size size) {
    return AppbarBase(
      checkIcon: true,
      backgroundColor: AppColors.background,
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
                value: .67,
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

  Widget _textField(String hintText) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.textSecondColor.withOpacity(.5),
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: _controllerPassword,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.emailAddress,
        obscureText: (isHide) ? true : false,
        onChanged: (value) {
          setState(() {
            checkButton = _controllerPassword.text.isNotEmpty;
          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          hintStyle: const TextStyle(
            fontSize: 18,
            color: AppColors.textSecondColor,
            fontWeight: FontWeight.bold,
          ),
          suffix: GestureDetector(
            onTap: () {
              setState(() {
                isHide = !isHide;
              });
            },
            child: SvgPicture.asset(
              (isHide == true) ? AppVectors.vtEye : AppVectors.vtHideEye,
              // ignore: deprecated_member_use
              color: AppColors.textThirdColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppTexts.tvPasswordTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          _textField(
            AppTexts.tvPasswordHint,
          ),
          const SizedBox(
            height: 32,
          ),
          BaseButton(
            onPressed: () async {
              courseId = await _getValueByKey('language');
              bio = await _getValueByKey('bio');

              log('Course id: $courseId');
              log('Bio: $bio');

              List<String> usernames = widget.name.toLowerCase().split(' ');
              final username = usernames.first + usernames.last;

              final data = await sl<SignupUseCase>().call(
                params: SignupModel(
                  email: widget.email,
                  name: widget.name,
                  username: username,
                  bio: bio,
                  courseId: courseId,
                  password: _controllerPassword.text.toString(),
                ),
              );

              if (checkButton == true) {
                data.fold(
                  (l) {},
                  (r) {
                    AppRoute.pushAndRemoveLeftToRight(
                      context,
                      const SignupSuccessPage(
                        text: AppTexts.tvSignupSuccessTitle,
                      ),
                    );
                  },
                );
              }
            },
            backgroundColor: (checkButton == null || checkButton == false)
                ? AppColors.textSecondColor.withOpacity(.5)
                : AppColors.textThirdColor,
            checkBorder: (checkButton == true) ? true : false,
            widget: Text(
              AppTexts.btnCreateAccount.toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                color: (checkButton == true)
                    ? AppColors.background
                    : AppColors.textSecondColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            const TextSpan(
              text: 'Khi đăng ký trên Duolingo, bạn đã đồng ý với ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondColor,
              ),
            ),
            TextSpan(
              text: 'Các chính sách ',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textColor.withOpacity(.8),
                fontWeight: FontWeight.w800,
              ),
            ),
            const TextSpan(
              text: 'và ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondColor,
              ),
            ),
            TextSpan(
              text: 'Chính sách bảo mật ',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textColor.withOpacity(.8),
                fontWeight: FontWeight.w800,
              ),
            ),
            const TextSpan(
              text: 'của chúng tôi. ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(size),
      body: _body(size),
      bottomNavigationBar: _bottomBar(),
    );
  }
}
