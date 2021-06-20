import 'package:get/get.dart';

import '../screens/auth/controllers/auth_controller.dart';
import '../screens/home/controllers/home_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
      fenix: true,
    );
  }
}
