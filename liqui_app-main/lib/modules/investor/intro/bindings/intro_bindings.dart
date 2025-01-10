import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/intro/controllers/intro_controller.dart';

class IntroBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IntroController());
  }
}