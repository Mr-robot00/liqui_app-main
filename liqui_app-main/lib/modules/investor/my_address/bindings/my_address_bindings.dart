import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/my_address/controllers/my_address_controllers.dart';

class MyAddressBindings implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => MyAddressController());
  }
}