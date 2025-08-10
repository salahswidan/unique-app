import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/core/themes/app_colors.dart';
import 'package:unique/features/main/presentation/controllers/main_page_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPageController>(
      init: MainPageController(),
      builder: (controller) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => controller.toggleCurrentIndex(index),
          currentIndex: controller.currentIndex,
          selectedItemColor: AppColors.primaryColor,
          selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.collections),
              label: 'Collections',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              label: 'Custom Poster',
            ),
          ],
        ),
        body: controller.toggleCurrentPage(),
      ),
    );
  }
}
