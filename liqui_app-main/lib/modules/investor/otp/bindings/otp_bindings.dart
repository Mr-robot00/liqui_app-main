import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/otp/controllers/otp_controller.dart';

class OtpBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController());
  }
}
