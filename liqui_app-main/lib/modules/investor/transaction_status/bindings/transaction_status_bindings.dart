import 'package:get/get.dart';

import '../controller/transaction_status_controller.dart';

class TransactionStatusBindings implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => TransactionStatusController());
  }
}