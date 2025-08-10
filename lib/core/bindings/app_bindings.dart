import 'package:get/get.dart';
import 'package:unique/features/main/presentation/controllers/main_page_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageController>(() => MainPageController());
  }
}
