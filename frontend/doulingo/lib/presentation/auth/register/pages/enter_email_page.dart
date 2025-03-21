import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/auth/register/bloc/sign_up_cubit.dart';
import 'package:doulingo/presentation/auth/register/bloc/sign_up_state.dart';
import 'package:doulingo/presentation/auth/register/pages/enter_name_page.dart';
import 'package:doulingo/presentation/auth/register/widgets/text_manual.dart';
import 'package:doulingo/presentation/auth/register/widgets/text_message.dart';
import 'package:doulingo/presentation/auth/signin/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EnterEmailPage extends StatefulWidget {
  const EnterEmailPage({super.key});

  @override
  State<EnterEmailPage> createState() => _EnterEmailPageState();
}

class _EnterEmailPageState extends State<EnterEmailPage> {
  final TextEditingController _controllerEmail = TextEditingController();
  bool? checkButton;
  String message = '';

  @override
  void dispose() {
    super.dispose();
    _controllerEmail.dispose();
    message = '';
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
      size: 18,
      color: (checkButton == true)
          ? AppColors.background
          : AppColors.textSecondColor,
      fw: FontWeight.w800,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(size),
      body: _body(size),
      bottomNavigationBar: const TextManual(),
    );
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
    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignupSuccessState) {
            bool userExist = state.isSuccess;

            if (userExist == true) {
              AppRoute.pushLeftToRight(
                context,
                const SigninPage(
                  checkUser: true,
                ),
              );
            } else {
              AppRoute.pushLeftToRight(
                context,
                EnterNamePage(
                  email: _controllerEmail.text.toString(),
                ),
              );
            }
          } else if (state is SignupFailureState) {
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
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextViewShow(
                    text: AppTexts.tvEmailTitle,
                    size: 20,
                    color: AppColors.textColor,
                    fw: FontWeight.w900,
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
                height: 12,
              ),
              TextMessage(message: message),
              const SizedBox(
                height: 32,
              ),
              _button(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) => BaseButton(
        onPressed: () async {
          if (checkButton == true) {
            context
                .read<SignUpCubit>()
                .userExist(_controllerEmail.text.toString());
          }
        },
        backgroundColor: (checkButton == null || checkButton == false)
            ? AppColors.textSecondColor.withOpacity(.5)
            : AppColors.textThirdColor,
        checkBorder: (checkButton == true) ? true : false,
        widget: (state is SignupLoading) ? _loading() : _initial(),
      ),
    );
  }
}
