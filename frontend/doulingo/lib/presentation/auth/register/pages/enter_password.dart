import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/local_data/use_case/get_data_use_case.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/data/auth/models/signup_req.dart';
import 'package:doulingo/presentation/auth/register/bloc/sign_up_cubit.dart';
import 'package:doulingo/presentation/auth/register/bloc/sign_up_state.dart';
import 'package:doulingo/presentation/auth/register/pages/signup_success_page.dart';
import 'package:doulingo/presentation/auth/register/widgets/text_manual.dart';
import 'package:doulingo/presentation/auth/register/widgets/text_message.dart';
import 'package:doulingo/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  String message = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerPassword.dispose();
  }

  Widget _loading() {
    return const SpinKitThreeBounce(
      color: AppColors.background,
      size: 30,
    );
  }

  Widget _initial() {
    return TextViewShow(
      text: AppTexts.btnCreateAccount.toUpperCase(),
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

  Widget _button() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return BaseButton(
          onPressed: (checkButton == true)
              ? () async {
                  courseId = await _getValueByKey('language');
                  bio = await _getValueByKey('bio');

                  List<String> usernames = widget.name.toLowerCase().split(' ');
                  final username = usernames.first + usernames.last;
                  if (!context.mounted) return;
                  context.read<SignUpCubit>().signup(
                        SignupModel(
                          email: widget.email,
                          name: widget.name,
                          username: username,
                          bio: bio,
                          courseId: courseId,
                          password: _controllerPassword.text.toString(),
                        ),
                      );
                }
              : () {},
          backgroundColor: (checkButton == null || checkButton == false)
              ? AppColors.textSecondColor.withOpacity(.5)
              : AppColors.textThirdColor,
          checkBorder: (checkButton == true) ? true : false,
          widget: (state is SignupLoading) ? _loading() : _initial(),
        );
      },
    );
  }

  Widget _body(Size size) {
    return BlocProvider<SignUpCubit>(
      create: (_) => SignUpCubit(),
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignupSuccessState) {
            AppRoute.pushAndRemoveLeftToRight(
              context,
              const SignupSuccessPage(
                text: AppTexts.tvSignupSuccessTitle,
              ),
            );
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
                    text: AppTexts.tvPasswordTitle,
                    size: 20,
                    fw: FontWeight.w900,
                    color: AppColors.textColor,
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
                height: 10,
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
}
