import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/domain/auth/use_case/check_user_use_case.dart';
import 'package:doulingo/presentation/auth/register/pages/enter_name_page.dart';
import 'package:doulingo/presentation/auth/signin_page.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';

class EnterEmailPage extends StatefulWidget {
  const EnterEmailPage({super.key});

  @override
  State<EnterEmailPage> createState() => _EnterEmailPageState();
}

class _EnterEmailPageState extends State<EnterEmailPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  bool? checkButton;

  @override
  void dispose() {
    super.dispose();
    _controllerEmail.dispose();
  }

  PreferredSizeWidget _appBar(Size size) {
    return AppbarBase(
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
                value: 0,
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
        controller: _controllerEmail,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          setState(() {
            checkButton = _controllerEmail.text.isNotEmpty;
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
                AppTexts.tvEmailTitle,
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
            AppTexts.tvEmailHint,
          ),
          const SizedBox(
            height: 32,
          ),
          _button(),
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

  Widget _button() {
    return BaseButton(
      onPressed: () async {
        if (checkButton == true) {
          bool checkUser = await sl<CheckUserUseCase>().call(
            params: _controllerEmail.text.toString(),
          );

          if (mounted) {
            if (checkUser) {
              AppRoute.push(
                context,
                const SigninPage(
                  checkUser: true,
                ),
              );
            } else {
              AppRoute.push(
                context,
                EnterNamePage(
                  email: _controllerEmail.text.toString(),
                ),
              );
            }
          }
        }
      },
      backgroundColor: (checkButton == null || checkButton == false)
          ? AppColors.textSecondColor.withOpacity(.5)
          : AppColors.textThirdColor,
      checkBorder: (checkButton == true) ? true : false,
      widget: Text(
        AppTexts.tvContinue,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: (checkButton == true)
              ? AppColors.background
              : AppColors.textSecondColor,
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
