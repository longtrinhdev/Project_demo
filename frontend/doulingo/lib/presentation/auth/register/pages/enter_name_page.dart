import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/button/base_button.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/auth/register/pages/enter_password.dart';
import 'package:doulingo/presentation/auth/register/widgets/text_manual.dart';
import 'package:flutter/material.dart';

class EnterNamePage extends StatefulWidget {
  final String email;
  const EnterNamePage({
    super.key,
    required this.email,
  });

  @override
  State<EnterNamePage> createState() => _EnterNamePageState();
}

class _EnterNamePageState extends State<EnterNamePage> {
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  bool oneField = false;
  bool twoField = false;

  @override
  void dispose() {
    _controllerFirstName.dispose();
    _controllerLastName.dispose();
    super.dispose();
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
                value: 0.33,
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
          _textField(_controllerFirstName, AppTexts.tvNameHint, false),
          Container(
            height: 1.5,
            color: AppColors.textSecondColor.withOpacity(.5),
          ),
          _textField(_controllerLastName, AppTexts.tvLastNameHint, true),
        ],
      ),
    );
  }

  Widget _textField(
      TextEditingController controller, String hintText, bool checkField) {
    return TextField(
      controller: controller,
      textInputAction: TextInputAction.done,
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
      ),
    );
  }

  Widget _body() {
    bool checkButton = oneField && twoField;
    return Column(
      children: [
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTexts.tvNameTitle,
              style: TextStyle(
                fontSize: 20,
                color: AppColors.textColor,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        _enterField(),
        const SizedBox(
          height: 24,
        ),
        BaseButton(
          onPressed: () {
            final name =
                "${_controllerFirstName.text} ${_controllerLastName.text}";
            if (checkButton) {
              AppRoute.pushLeftToRight(
                context,
                EnterPasswordPage(
                  name: name,
                  email: widget.email,
                ),
              );
            }
          },
          backgroundColor: (checkButton)
              ? AppColors.textThirdColor
              : AppColors.textSecondColor.withOpacity(.5),
          checkBorder: (checkButton) ? true : false,
          widget: Text(
            AppTexts.tvContinue.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              color: (checkButton)
                  ? AppColors.background
                  : AppColors.textSecondColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(size),
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(16),
        child: _body(),
      ),
      bottomNavigationBar: const TextManual(),
    );
  }
}
