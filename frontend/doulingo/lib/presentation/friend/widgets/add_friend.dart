import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/divider/app_divider.dart';
import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/friend/widgets/search_friend.dart';
import 'package:flutter/material.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({super.key});

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: _body(size),
    );
  }

  PreferredSizeWidget _appBar() {
    return const AppbarBase(
      backgroundColor: AppColors.background,
      checkIcon: true,
      title: TextViewShow(
        text: AppTexts.tvSearchFriend,
        size: 20,
        color: AppColors.textSecondColor,
        fw: FontWeight.w800,
      ),
    );
  }

  Widget _body(Size size) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          _textField(),
          const SizedBox(
            height: 12,
          ),
          const AppDivider(),
          const SizedBox(
            height: 16,
          ),
          const Expanded(
            child: SearchFriend(),
          ),
        ],
      ),
    );
  }

  _textField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        controller: _controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.unselect,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: AppColors.textThirdColor,
              width: 2.0,
            ),
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 27,
            color: AppColors.textSecondColor.withOpacity(.8),
          ),
          hintText: AppTexts.tvHintSearch,
          hintStyle: TextStyle(
            fontSize: 18,
            color: AppColors.textColor.withOpacity(.8),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
