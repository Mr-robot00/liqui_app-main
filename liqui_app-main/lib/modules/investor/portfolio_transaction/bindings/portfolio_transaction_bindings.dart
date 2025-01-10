import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/portfolio_transaction/controllers/portfolio_transaction_controller.dart';

class PortfolioTransactionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PortfolioTransactionController());
  }
}
