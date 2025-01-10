import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/withdraw_fund/controllers/withdraw_fund_controller.dart';

class WithdrawFundBindings implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => WithdrawFundController());
  }
}