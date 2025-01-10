import 'dart:convert';

import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/networking/my_repositories.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/index.dart';

class MakePaymentController extends GetxController {
  var isLoading = false.obs;
  // var payloadRes = [].obs;
  String investmentType = "";
  String selectedAmount = "";
  String schemeId = "";
  String selectedPG = "";
  String interestAmount = "";

  //Error handling
  var errorMsg = ''.obs;
  var retryError = "";
  var overlayLoading = true.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      investmentType = Get.arguments["investmentType"];
      selectedAmount = Get.arguments["amount"];
      schemeId = Get.arguments["schemeId"];
      interestAmount = Get.arguments["interestAmount"] ?? '0';
    }
    super.onInit();
  }

  void makePayment(String pgType) {
    selectedPG = pgType;
    callCreatePaymentPayload();
  }

  void callCreatePaymentPayload() async {
    final params = {
      'investor_id': myLocal.userId,
      "scheme_id": schemeId,
      "amount": selectedAmount,
      "payment_gateway": selectedPG,
      "transaction_source": 'MobileApp',
      "redirect_to": 'AppSource',
    };
    updateError(isError: true, showOverlay: true);
    myRepo.createPaymentPayload(params).asStream().handleError((error) {
      updateError(
          isError: true, msg: error.toString(), retry: 'create_payload');
    }).listen((response) async {
      updateError();
      if (response.status!) {
        var dataUrl = response.payloadData?.url ?? "";
        if (dataUrl == "") {
          updateError(isError: true, msg: "something_went_wrong".tr);
        } else {
          logEvent.investFundStarted(
              schemeId: int.parse(schemeId.validString ? schemeId : "0"),
              amount:
                  num.parse(selectedAmount.validString ? selectedAmount : "0"),
              gatewayType: selectedPG,
              page: "page_${paymentGatewayScreen.substring(1)}");
          var dataPayload = jsonEncode(response.payloadData!.payload!);
          var webUri = Uri.dataFromString(
            '''<html> 
                  <head> 
                    <title>Merchant Checkout Page</title> 
                  </head> 
                  <body onload="myFunction()"> 
                  <center>
                   <h1>Please do not refresh this page...</h1> 
                   </center> <input type="hidden" value=$dataUrl id="hidUrl"/>
                   <input type="hidden" value=$dataPayload id="hidPayload"/> '''
            r'''
                   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/jquery.redirect@1.1.4/jquery.redirect.min.js"></script> 
                    <script type="text/javascript">
                    function myFunction(){
                      var url=$("#hidUrl").val(); 
                      var payload=JSON.parse($("#hidPayload").val());
                        $.redirect(url, payload, "POST");
                    }
                       </script> 
                    </body>
                </html>''',
            mimeType: 'text/html',
            encoding: Encoding.getByName('utf-8'),
          );
          var status = await Get.toNamed(webViewScreen, arguments: {
            "webUri": webUri,
            "showAppbar": false,
            "preventBack": true,
            "amount": selectedAmount
          });
          if (status != null) {
            if (status == "failure") {
              logEvent.paymentStatus(
                  amount: num.parse(
                      selectedAmount.validString ? selectedAmount : "0"),
                  transactionId: "",
                  transactionStatus: "Transaction Failed",
                  page: "page_${paymentGatewayScreen.substring(1)}");
              myWidget.showPopUp("transaction_failed".tr);
            }
          } else {
            logEvent.paymentStatus(
                amount: num.parse(
                    selectedAmount.validString ? selectedAmount : "0"),
                transactionId: "",
                transactionStatus: "Transaction Cancelled",
                page: "page_${paymentGatewayScreen.substring(1)}");
            myWidget.transactionCancelledAlertDialog(
                interestRupees: interestAmount,
                clickContinue: () {
                  makePayment(selectedPG);
                  logEvent.retryPayment(
                      schemeId:
                          int.parse(schemeId.validString ? schemeId : "0"),
                      amount: num.parse(
                          selectedAmount.validString ? selectedAmount : "0"),
                      gatewayType: selectedPG,
                      page: "page_${paymentGatewayScreen.substring(1)}");
                  Get.back();
                },
                clickCancel: () {
                  logEvent.retryPaymentCancelled(
                      schemeId:
                          int.parse(schemeId.validString ? schemeId : "0"),
                      amount: num.parse(
                          selectedAmount.validString ? selectedAmount : "0"),
                      gatewayType: selectedPG,
                      page: "page_${paymentGatewayScreen.substring(1)}");
                  Get.back();
                });
          }
        }
      } else {
        updateError(
            isError: true,
            msg: response.message.toString(),
            retry: 'create_payload');
      }
    });
  }

  void updateLoading({bool loading = false}) {
    isLoading.value = loading;
  }

  void handleRetryAction() {
    updateLoading();
    switch (retryError) {
      case 'create_payload':
        callCreatePaymentPayload();
        break;
      default:
        updateError();
        break;
    }
  }

  updateError(
      {bool isError = false,
      String msg = '',
      String retry = '',
      bool showOverlay = false}) {
    overlayLoading.value = showOverlay;
    isLoading.value = isError;
    errorMsg.value = msg;
    retryError = retry;
  }
}
