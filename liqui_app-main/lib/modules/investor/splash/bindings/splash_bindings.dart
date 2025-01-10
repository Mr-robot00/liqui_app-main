import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/splash/controllers/splash_controller.dart';

class SplashBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());

  }
}
