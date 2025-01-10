import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/signup/add_address/controllers/add_address_controller.dart';

class AddAddressBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AddAddressController());
  }

}