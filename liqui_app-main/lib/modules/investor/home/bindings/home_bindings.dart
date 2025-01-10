import 'package:get/instance_manager.dart';
import 'package:liqui_app/modules/investor/dashboard/controllers/dashboard_controller.dart';
import 'package:liqui_app/modules/investor/home/controllers/home_controller.dart';
import 'package:liqui_app/modules/investor/home/controllers/max_invest_controller.dart';
import 'package:liqui_app/modules/investor/profile/controllers/profile_controller.dart';
import 'package:liqui_app/modules/investor/select_folio/controllers/hierarchy_controller.dart';
import 'package:liqui_app/modules/investor/transactions/controllers/transactions_controller.dart';

import '../../portfolio_transaction/controllers/portfolio_transaction_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => HierarchyController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => PortfolioTransactionController());
    Get.lazyPut(() => TransactionsController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => MinMaxInvestController());
  }
}
