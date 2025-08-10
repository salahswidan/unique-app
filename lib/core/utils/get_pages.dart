import 'package:get/get.dart';
import 'package:unique/core/constants/app_route.dart';
import 'package:unique/features/auth/presentation/pages/sign_up_page.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(name: AppRoute.signUpPage, page: () => SignUpPage()),
];
