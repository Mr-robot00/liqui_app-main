import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/deposit_funds/controllers/deposit_funds_controller.dart';

class DepositFundsBindings extends Bindings {
  @override
  void dependencies() {
    /// set [fenix] property to true
    /// to recreate the instance when needed if it is removed from memory
    Get.lazyPut(() => DepositFundsController(), fenix: true);

  }
}
