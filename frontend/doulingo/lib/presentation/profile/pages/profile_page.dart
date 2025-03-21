import 'package:doulingo/common/widget/divider/app_divider.dart';
import 'package:doulingo/presentation/profile/widgets/profile_header.dart';
import 'package:doulingo/presentation/profile/widgets/profile_intro.dart';
import 'package:doulingo/presentation/profile/widgets/profile_overview.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 1.5,
      child: const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ProfileHeaderWidget(),
            ProfileIntroWidget(),
            AppDivider(),
            ProfileOverview(),
          ],
        ),
      ),
    );
  }
}
