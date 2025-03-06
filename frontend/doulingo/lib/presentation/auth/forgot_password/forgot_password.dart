import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';
import 'package:doulingo/domain/auth/use_case/forgot_pw.dart';
import 'package:doulingo/presentation/auth/register/pages/signup_success_page.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _controllerEmail = TextEditingController();
  bool _checkHidden = false;
  String message = AppTexts.tvPasswordContent;

  @override
  void dispose() {
    super.dispose();
    _controllerEmail.dispose();
  }

  PreferredSizeWidget _appBar() {
    return const AppbarBase(
      backgroundColor: AppColors.background,
    );
  }

  Widget _textTitle(String title, bool checkTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: checkTitle ? 22 : 16,
            fontWeight: checkTitle ? FontWeight.w900 : FontWeight.w800,
            color: checkTitle ? AppColors.textColor : AppColors.textSecondColor,
          ),
        ),
      ],
    );
  }

  Widget _enterField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1.5,
          color: AppColors.textSecondColor.withOpacity(.8),
        ),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _checkHidden = controller.text.isNotEmpty;
          });
        },
        keyboardType: TextInputType.emailAddress,
        controller: controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(12),
          border: InputBorder.none,
          hintText: 'Email',
          hintStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textSecondColor,
          ),
        ),
      ),
    );
  }

  Widget _button() {
    return BaseButton(
      onPressed: () async {
        final data = await sl<ForgotPwUseCase>().call(
          params: SignupModel(
            email: _controllerEmail.text,
          ),
        );
        data.fold(
          (l) {
            setState(() {
              message = l;
            });
          },
          (r) {
            AppRoute.pushAndRemoveLeftToRight(
              context,
              const SignupSuccessPage(
                text: AppTexts.tvSignupSuccessContent,
              ),
            );
          },
        );
      },
      backgroundColor:
          _checkHidden ? AppColors.textThirdColor : AppColors.unselect,
      checkBorder: _checkHidden ? true : false,
      widget: Text(
        AppTexts.tvContinue,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          color:
              _checkHidden ? AppColors.background : AppColors.textSecondColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _textTitle(
              AppTexts.tvForgotPassword,
              true,
            ),
            const SizedBox(
              height: 16,
            ),
            _enterField(_controllerEmail),
            const SizedBox(
              height: 8,
            ),
            _textTitle(
              AppTexts.tvPasswordContent,
              false,
            ),
            const Spacer(),
            _button(),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
