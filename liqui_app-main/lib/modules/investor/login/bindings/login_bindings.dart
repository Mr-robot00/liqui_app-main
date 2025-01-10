import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/login/controllers/login_controller.dart';

class LoginBindings implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
