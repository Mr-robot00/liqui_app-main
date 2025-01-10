import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/signup/sign_agreement/controllers/sign_agreement_controller.dart';

class SignAgreementBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignAgreementController());
  }
}