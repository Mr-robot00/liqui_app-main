import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/test/controllers/test_controller.dart';

class TestBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TestController());
  }
}
