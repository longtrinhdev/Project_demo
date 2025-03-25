import 'package:doulingo/common/helpers/navigation/app_route.dart';
import 'package:doulingo/common/widget/app_bar/appbar_base.dart';
import 'package:doulingo/common/widget/divider/app_divider.dart';
import 'package:doulingo/common/widget/text/app_textview.dart';
import 'package:doulingo/core/config/theme/app_colors.dart';
import 'package:doulingo/core/constant/app_texts.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _appBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppDivider(),
            _breadcrumb(),
            Expanded(
              child: TabBarView(
                children: [
                  _pageOne(),
                  const SizedBox(),
                ],
              ),
            ),
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
        text: AppTexts.appName,
        size: 30,
        color: AppColors.primaryColor,
        fw: FontWeight.w800,
      ),
    );
  }

  Widget _breadcrumb() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppTexts.tvSupport.toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 5),
            const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {},
              child: Text(
                AppTexts.tvHome.toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pageOne() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                AppTexts.tvans,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSection(
              "Sử dụng Duolingo",
              [
                "Tại sao khóa học của tôi thay đổi?",
                "Streak là gì?",
                "Bảng xếp hạng và Giải đấu là gì?",
                "Duolingo có sử dụng thư viện mở nào không?",
              ],
            ),
            const SizedBox(height: 20),
            _buildSection(
              "Quản lý tài khoản",
              [
                "Làm cách nào để đổi tên người dùng hoặc địa chỉ email?",
                "Làm cách nào để tìm kiếm, theo dõi và chặn người dùng khác trên Duolingo?",
                "Làm cách nào để gỡ hoặc đặt lại một khóa học?",
                "Tôi gặp vấn đề khi truy cập tài khoản.",
                "Làm cách nào để xóa tài khoản và kiểm tra dữ liệu của tôi?",
                "Những việc cần làm khi bị rò rỉ dữ liệu",
              ],
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Bạn có thắc mắc khác?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  elevation: 3,
                ),
                child: const Text(
                  "GỬI PHẢN HỒI",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> questions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        ...questions.map(
          (question) => Column(
            children: [
              _buildQuestionTile(question),
              const AppDivider(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionTile(String question) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Ans: $question"),
        ),
      ],
    );
  }
}
