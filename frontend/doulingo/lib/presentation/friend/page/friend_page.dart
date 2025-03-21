import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/divider/app_divider.dart';
import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:doulingo/presentation/friend/widgets/add_friend.dart';
import 'package:flutter/material.dart';

class FriendlyPage extends StatefulWidget {
  const FriendlyPage({
    super.key,
  });

  @override
  State<FriendlyPage> createState() => _FriendlyPageState();
}

class _FriendlyPageState extends State<FriendlyPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _appBar(),
        body: Column(
          children: [
            const AppDivider(),
            _tapBar(
              AppTexts.tvFollowers,
              AppTexts.tvFollowing,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _pageOne(),
                  const SizedBox(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return const AppbarBase(
      backgroundColor: AppColors.background,
      checkIcon: true,
      title: TextViewShow(
        text: AppTexts.tvFriendTitle,
        size: 20,
        color: AppColors.textSecondColor,
        fw: FontWeight.w800,
      ),
    );
  }

  Widget _tapBar(String tabTitle1, String tabTitle2) {
    return TabBar(
      dividerColor: AppColors.unselect,
      dividerHeight: 2,
      indicatorColor: AppColors.textThirdColor,
      labelStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
      labelColor: AppColors.textThirdColor,
      unselectedLabelColor: AppColors.textSecondColor.withOpacity(.8),
      tabs: [
        Tab(
          text: tabTitle1,
        ),
        Tab(
          text: tabTitle2,
        ),
      ],
    );
  }

  Widget _pageOne() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            AppRoute.pushLeftToRight(
              context,
              const AddFriend(),
            );
          },
          child: TextViewShow(
            text: AppTexts.btnAddFriend.toUpperCase(),
            size: 18,
            color: AppColors.textThirdColor,
            fw: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
