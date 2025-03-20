import 'package:doulingo/core/config/assets/app_vectors.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/presentation/rank/widgets/rank_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RankUser {
  final String avatar;
  final String name;
  final num score;

  RankUser({
    required this.avatar,
    required this.name,
    required this.score,
  });
}

class RankBodyWidget extends StatefulWidget {
  const RankBodyWidget({super.key});

  @override
  State<RankBodyWidget> createState() => _RankBodyWidgetState();
}

class _RankBodyWidgetState extends State<RankBodyWidget> {
  List<RankUser> list = [
    RankUser(
      avatar:
          'https://simg-ssl.duolingo.com/ssr-avatars/645788506/SSR-BebHkn6RAp/medium',
      name: 'BebHkn6RAp',
      score: 220,
    ),
    RankUser(
      avatar:
          'https://simg-ssl.duolingo.com/ssr-avatars/753640674/SSR-vFMJrndNs4/medium',
      name: 'VFMJrndNs4',
      score: 200,
    ),
    RankUser(
      avatar:
          'https://simg-ssl.duolingo.com/ssr-avatars/1158324738/SSR-MDeWvKmdyf/medium',
      name: 'Long',
      score: 160,
    ),
    RankUser(
      avatar:
          'https://simg-ssl.duolingo.com/ssr-avatars/1342797057/SSR-u6Bxcil9YD/medium',
      name: 'U6Bxcil9YD',
      score: 150,
    ),
    RankUser(
      avatar:
          'https://simg-ssl.duolingo.com/ssr-avatars/1656982275/SSR-F7s8_2r1LB/medium',
      name: 'unicode',
      score: 120,
    ),
    RankUser(
      avatar:
          'https://simg-ssl.duolingo.com/ssr-avatars/1075311366/SSR-VJOXrlpJ_v/medium',
      name: 'BebHkn6RAp',
      score: 100,
    ),
    RankUser(
      avatar:
          'https://simg-ssl.duolingo.com/ssr-avatars/1209230388/SSR-VEzjwa5_Rf/medium',
      name: 'BebHkn6RAp',
      score: 90,
    ),
    RankUser(
      avatar:
          'https://simg-ssl.duolingo.com/ssr-avatars/1209230388/SSR-VEzjwa5_Rf/medium',
      name: 'BebHkn6RAp',
      score: 90,
    ),
    RankUser(
      avatar:
          'https://simg-ssl.duolingo.com/ssr-avatars/1209230388/SSR-VEzjwa5_Rf/medium',
      name: 'BebHkn6RAp',
      score: 90,
    ),
  ];
  int indexUser = 6;
  late ScrollController _scrollController;
  bool isUserVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_checkUserVisible);
  }

  void _checkUserVisible() {
    double offset = _scrollController.offset;

    setState(() {
      isUserVisible = offset >= (indexUser * 60.0 - 300) &&
          offset <= (indexUser * 60 + 300);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            itemCount: list.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return RankItem(
                leading: _leading(index),
                title: _title(list[index]),
                trailing: _trailing(list[index]),
              );
            },
          ),
        ),
        if (!isUserVisible)
          RankItem(
            leading: _leading(indexUser),
            title: _title(list[indexUser]),
            trailing: _trailing(list[indexUser]),
            checkUser: true,
          ),
      ],
    );
  }

  Widget _leading(int index) {
    final child = (switch (index) {
      0 => SvgPicture.asset(AppVectors.icAu),
      1 => SvgPicture.asset(AppVectors.icAg),
      2 => SvgPicture.asset(AppVectors.icCu),
      3 => _text(index, AppColors.secondColor),
      4 => _text(index, AppColors.secondColor),
      (_) => _text(index, AppColors.textColor),
    });
    return child;
  }

  Widget _title(RankUser user) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Image.network(
            user.avatar,
            width: 48,
            height: 48,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          user.name,
          style: const TextStyle(
            color: AppColors.textColor,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _trailing(RankUser user) {
    return Text(
      '${user.score} KNN',
      style: TextStyle(
        fontSize: 18,
        color: AppColors.textColor.withOpacity(.8),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _text(int index, Color color) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      child: Text(
        '${index + 1}',
        style: TextStyle(
          fontSize: 18,
          color: color,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
