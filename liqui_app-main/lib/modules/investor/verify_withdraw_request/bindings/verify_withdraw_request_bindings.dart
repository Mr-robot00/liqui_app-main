import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/verify_withdraw_request/controller/verify_withdraw_request_controller.dart';

class VerifyWithdrawRequestBindings implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => VerifyWithdrawRequestController());
  }
}