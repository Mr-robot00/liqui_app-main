import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/signup/add_bank_account/controllers/add_bank_account_controller.dart';

class AddBankAccountBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddBankAccountController());
  }
}