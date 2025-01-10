import 'package:get/instance_manager.dart';
import 'package:liqui_app/modules/investor/select_folio/controllers/hierarchy_controller.dart';

class HierarchyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HierarchyController());
  }
}
