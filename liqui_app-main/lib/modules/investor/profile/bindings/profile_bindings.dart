import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/profile/controllers/profile_controller.dart';

class ProfileBindings implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}