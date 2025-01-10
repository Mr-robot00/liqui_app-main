import 'package:get/get.dart';
import 'package:liqui_app/modules/investor/upload_bank_document/controller/upload_bank_document_controller.dart';

class UploadBankDocumentBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(UploadBankDocumentController());
  }
}