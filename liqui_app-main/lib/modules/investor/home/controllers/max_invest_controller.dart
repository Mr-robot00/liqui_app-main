import 'package:get/get.dart';
import 'package:liqui_app/global/config/responses/index.dart';
import '../../../../global/config/routes/app_routes.dart';
import '../../../../global/networking/my_repositories.dart';
import '../../../../global/utils/storage/my_local.dart';
import '../../deposit_funds/controllers/deposit_funds_controller.dart';

class MinMaxInvestController extends GetxController {
  var maxInvResponse = MinMaxInvestmentResponse().obs;
  var loading = false;
  var minMaxInvestmentAmountFetched = false.obs;

  Future<List<dynamic>> callGetMinMaxInvestment() async {
    var result = [];
    loading = true;
    final params = {'investor_id': myLocal.userId};
    myRepo.minMaxInvestmentAmount(params).asStream().handleError((error) {
      result = [false, error.toString()];
      loading = false;
    }).listen((response) {
      if (response.status!) {
        maxInvResponse.value = response;
      }
      result = [response.status, response.message];
      minMaxInvestmentAmountFetched.value =
          maxInvResponse.value.minMaxInvestment != null;
      loading = false;
    });
    while (result.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    checkInvestmentLimit(result[0],msg: result[1]);
    return result;
  }

  void checkInvestmentLimit(bool status, {String? msg}) {
    if (Get.currentRoute == depositFundsScreen) {
      DepositFundsController deposit = Get.find();
      deposit.investmentDataFetched(status,msg: msg);
    }
  }

  num get maxInvestmentAmount => minMaxInvestmentAmountFetched.value
      ? num.parse(maxInvResponse.value.minMaxInvestment!.maxInvestmentAllowed!
          .toStringAsFixed(2))
      : 0;

  num get minInvestmentAmount => minMaxInvestmentAmountFetched.value
      ? num.parse(maxInvResponse.value.minMaxInvestment!.minInvestmentAllowed!
          .toStringAsFixed(2))
      : 5000;
}
