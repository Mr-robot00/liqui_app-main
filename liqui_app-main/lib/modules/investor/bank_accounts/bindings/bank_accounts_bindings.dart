import 'package:get/get.dart';

import '../controllers/bank_accounts_controller.dart';



class BankAccountBindings implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => BankAccountsController());
  }
}