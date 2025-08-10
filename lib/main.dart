import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/core/bindings/app_bindings.dart';
import 'package:unique/core/constants/app_route.dart';
import 'package:unique/core/utils/get_pages.dart';
import 'package:unique/features/auth/presentation/pages/login_page.dart';
import 'package:unique/features/auth/presentation/pages/sign_up_page.dart';
import 'package:unique/features/main/presentation/pages/main_page.dart';

void main() {
  runApp(const UniqueApp());
}

class UniqueApp extends StatelessWidget {
  const UniqueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
      ),
      initialBinding: AppBindings(),
      getPages: getPages,
      home: MainPage(),
    );
  }
}
