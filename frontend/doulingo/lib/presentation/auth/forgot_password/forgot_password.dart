import 'package:doulingo/common/bloc/generate_cubit.dart';
import 'package:doulingo/common/bloc/generate_data_state.dart';
import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';
import 'package:doulingo/domain/auth/use_case/forgot_pw.dart';
import 'package:doulingo/presentation/auth/register/pages/signup_success_page.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _controllerEmail = TextEditingController();
  bool _checkHidden = false;
  bool _checkMessage = false;
  String message = AppTexts.tvPasswordContent;

  @override
  void dispose() {
    super.dispose();
    _controllerEmail.dispose();
  }

  Widget _loading() {
    return const SpinKitThreeBounce(
      color: AppColors.background,
      size: 30,
    );
  }

  Widget _initial() {
    return TextViewShow(
      text: AppTexts.tvContinue,
      size: 20,
      color: _checkHidden ? AppColors.background : AppColors.textSecondColor,
      fw: FontWeight.w800,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: BlocProvider<GenerateCubit>(
        create: (_) => GenerateCubit(),
        child: BlocListener<GenerateCubit, GenerateDataState>(
          listener: (context, state) {
            if (state is DataLoaded) {
              AppRoute.pushAndRemoveLeftToRight(
                context,
                const SignupSuccessPage(
                  text: AppTexts.tvSignupSuccessContent,
                ),
              );
            } else if (state is DataLoadedFailure) {
              setState(() {
                message = state.errorMessage;
                _checkMessage = true;
              });
            }
          },
          child: Container(
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
                  message,
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
        ),
      ),
    );
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
        TextViewShow(
          text: title,
          size: checkTitle ? 22 : 16,
          color: checkTitle
              ? AppColors.textColor
              : (_checkMessage)
                  ? Colors.red
                  : AppColors.textSecondColor,
          fw: checkTitle ? FontWeight.w900 : FontWeight.w800,
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
    return BlocBuilder<GenerateCubit, GenerateDataState>(
      builder: (context, state) {
        return BaseButton(
          onPressed: (_checkHidden == true)
              ? () async {
                  context.read<GenerateCubit>().getData(sl<ForgotPwUseCase>(),
                      params: SignupModel(email: _controllerEmail.text));
                }
              : () {},
          backgroundColor:
              _checkHidden ? AppColors.textThirdColor : AppColors.unselect,
          checkBorder: _checkHidden ? true : false,
          widget: (state is DataLoading) ? _loading() : _initial(),
        );
      },
    );
  }
}
