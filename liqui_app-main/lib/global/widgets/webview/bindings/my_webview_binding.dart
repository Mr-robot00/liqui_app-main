import 'package:get/get.dart';
import 'package:liqui_app/global/widgets/webview/controllers/my_webview_controller.dart';

class MyWebViewBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyWebViewController());
  }
}
