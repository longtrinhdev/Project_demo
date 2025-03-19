import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/auth/forgot_password/forgot_password.dart';
import 'package:doulingo/presentation/auth/signin/bloc/sign_in_cubit.dart';
import 'package:doulingo/presentation/auth/signin/bloc/sign_in_state.dart';
import 'package:doulingo/presentation/auth/signin/widgets/footer_widget.dart';
import 'package:doulingo/presentation/main/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  Widget _loading() {
    return const SpinKitThreeBounce(
      color: AppColors.background,
      size: 30,
    );
  }

  Widget _success(checkButton) {
    return Text(
      AppTexts.btnLogin,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: (checkButton) ? AppColors.background : AppColors.textSecondColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appbar(),
      body: BlocProvider(
        create: (context) => SignInCubit(),
        child: BlocListener<SignInCubit, SignInState>(
          listener: (context, state) async {
            if (state is SigninSuccessState) {
              final userEntity = state.user;
              AppRoute.pushAndRemoveBottomToTop(
                context,
                MainPage(
                  courseId: userEntity.courseId![0],
                  learnDays: userEntity.learnDays,
                  score: userEntity.score,
                ),
              );
            } else if (state is SigninErrorState) {
              setState(() {
                message = state.errorMessage;
              });
            }
          },
          child: Container(
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
                FooterWidget(
                  userExist: widget.checkUser,
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return BaseButton(
          onPressed: checkButton
              ? () {
                  context.read<SignInCubit>().signIn(
                        _controllerMail.text,
                        _controllerPassword.text,
                      );
                }
              : () {},
          backgroundColor:
              checkButton ? AppColors.textThirdColor : AppColors.unselect,
          widget:
              state is SigninLoadingState ? _loading() : _success(checkButton),
          checkBorder: (checkButton) ? true : false,
        );
      },
    );
  }

  Widget _forgotPassword() {
    return GestureDetector(
      onTap: () {
        AppRoute.pushBottomToTop(
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
}
