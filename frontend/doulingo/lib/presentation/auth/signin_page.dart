import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/data/auth/models/signin_req.dart';
import 'package:doulingo/domain/auth/entities/user.dart';
import 'package:doulingo/domain/auth/use_case/signin_use_case.dart';
import 'package:doulingo/presentation/auth/forgot_password/forgot_password.dart';
import 'package:doulingo/presentation/main/pages/main_page.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SigninPage extends StatefulWidget {
  final bool? checkUser;
  const SigninPage({
    super.key,
    this.checkUser = false,
  });

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _controllerMail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool isHideEye = true;
  bool oneField = false;
  bool twoField = false;
  String message = '';

  @override
  void dispose() {
    super.dispose();
    _controllerMail.dispose();
    _controllerPassword.dispose();
  }

  PreferredSizeWidget _appbar() {
    return AppbarBase(
      title: (widget.checkUser == true)
          ? null
          : const Text(
              AppTexts.signinPageTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.textSecondColor,
              ),
            ),
      backgroundColor: AppColors.background,
    );
  }

  Widget _enterField() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.textSecondColor.withOpacity(.5),
            width: 1.5,
          )),
      child: Column(
        children: [
          _textField(_controllerMail, AppTexts.tvHintUsername, false, true),
          Container(
            height: 1.5,
            color: AppColors.textSecondColor.withOpacity(.5),
          ),
          _textField(_controllerPassword, AppTexts.tvHintPassword, true, false),
        ],
      ),
    );
  }

  Widget _textField(TextEditingController controller, String hintText,
      bool checkSuffix, bool checkField) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.done,
      obscureText: (checkSuffix == true) ? isHideEye : false,
      onChanged: (value) {
        if (checkField == true) {
          setState(() {
            {
              oneField = controller.text.isNotEmpty;
            }
          });
        }
        if (checkField == false) {
          setState(() {
            twoField = controller.text.isNotEmpty;
          });
        }
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
        suffix: checkSuffix != true
            ? null
            : GestureDetector(
                onTap: () {
                  setState(() {
                    isHideEye = !isHideEye;
                  });
                },
                child: SvgPicture.asset(
                  (isHideEye == true) ? AppVectors.vtEye : AppVectors.vtHideEye,
                  // ignore: deprecated_member_use
                  color: AppColors.textThirdColor,
                ),
              ),
      ),
    );
  }

  Widget _message(Size size) {
    return SizedBox(
      width: size.width,
      child: Text(
        textAlign: TextAlign.start,
        message,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buttonSignIn() {
    bool checkButton = oneField && twoField;
    return BaseButton(
      onPressed: checkButton
          ? () async {
              setState(() {
                message = '';
              });
              final data = await sl<SigninUseCase>().call(
                params: SigninModel(
                  username: _controllerMail.text,
                  password: _controllerPassword.text,
                ),
              );
              final courseId = await _getValueByKey('language');
              return data.fold(
                (l) {
                  setState(() {
                    message = l;
                  });
                },
                (r) {
                  UserEntity userEntity = r as UserEntity;
                  AppRoute.pushAndRemove(
                    context,
                    MainPage(
                      courseId: courseId,
                      learnDays: userEntity.learnDays,
                      score: userEntity.score,
                    ),
                  );
                },
              );
            }
          : () {},
      backgroundColor:
          checkButton ? AppColors.textThirdColor : AppColors.unselect,
      widget: Text(
        AppTexts.btnLogin,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color:
              (checkButton) ? AppColors.background : AppColors.textSecondColor,
        ),
      ),
      checkBorder: (checkButton) ? true : false,
    );
  }

  Widget _forgotPassword() {
    return GestureDetector(
      onTap: () {
        AppRoute.push(
          context,
          const ForgotPassword(),
        );
      },
      child: const Text(
        AppTexts.btnForgotPassword,
        style: TextStyle(
          fontSize: 18,
          color: AppColors.textThirdColor,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget __signInOr() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.textSecondColor.withOpacity(.5),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        const Text(
          AppTexts.tvOr,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textSecondColor,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.textSecondColor.withOpacity(.5),
          ),
        ),
      ],
    );
  }

  Widget _buttonSignOr(Widget widget, bool checkIcon) {
    return BaseButton(
      onPressed: () {},
      backgroundColor: AppColors.background,
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (checkIcon)
              ? SvgPicture.asset(AppVectors.icFacebook)
              : SvgPicture.asset(AppVectors.icGoogle),
          const SizedBox(
            width: 8,
          ),
          widget,
        ],
      ),
      checkBorder: true,
    );
  }

  Widget _textSignOr(String title, bool checkIcon) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: checkIcon ? const Color(0xff5A678D) : AppColors.textSecondColor,
      ),
    );
  }

  Widget _signInOr() {
    return Row(
      children: [
        Expanded(
          child: _buttonSignOr(
            _textSignOr(AppTexts.tvFacebook, true),
            true,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: _buttonSignOr(
            _textSignOr(AppTexts.tvGoogle, false),
            false,
          ),
        ),
      ],
    );
  }

  Widget _messageCheckAccount() {
    return const Text(
      AppTexts.tvCheckUserTitle,
      style: TextStyle(
        fontSize: 21,
        color: AppColors.textColor,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Future<String> _getValueByKey(String key) async {
    final courseId = await sl<GetDataUseCase>().call(
      params: key,
    );
    return courseId;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appbar(),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            (widget.checkUser == true)
                ? _messageCheckAccount()
                : const SizedBox(),
            (widget.checkUser == true)
                ? const SizedBox(
                    height: 16,
                  )
                : const SizedBox(),
            _enterField(),
            const SizedBox(
              height: 8,
            ),
            _message(size),
            const SizedBox(
              height: 16,
            ),
            _buttonSignIn(),
            const SizedBox(
              height: 24,
            ),
            _forgotPassword(),
            const Spacer(),
            (widget.checkUser == false) ? __signInOr() : const SizedBox(),
            (widget.checkUser == false)
                ? const SizedBox(height: 16)
                : const SizedBox(),
            (widget.checkUser == false) ? _signInOr() : const SizedBox(),
            (widget.checkUser == false)
                ? const SizedBox(height: 32)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
