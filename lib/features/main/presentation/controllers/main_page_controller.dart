import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/features/collections/presentation/pages/collections_page.dart';
import 'package:unique/features/custom_poster/presentation/pages/custom_poster.dart';

class MainPageController extends GetxController {
  int currentIndex = 0;

  void toggleCurrentIndex(int index) {
    currentIndex = index;
    update();
  }

  Widget toggleCurrentPage() {
    switch (currentIndex) {
      case 0:
        return CollectionsPage();
      case 1:
        return CustomPoster();
      default:
        return Container();
    }
  }
}
