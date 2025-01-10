import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/helpers/print_log.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/widgets/index.dart';

import 'controllers/test_controller.dart';

class Test extends GetView<TestController> {
  const Test({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Test'),
      body: Container(
        margin: const EdgeInsets.all(padding10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (controller.imagePath.value.isNotEmpty)
              Image.file(
                File(controller.imagePath.value),
                width: 250,
                height: 250,
                fit: BoxFit.fill,
              ),
            const SizedBox(height: padding50),
            MyButton(
              onPressed: () async {
                // var result = await Get.toNamed(captureImageScreen);
                final XFile? result = await controller.picker
                    .pickImage(source: ImageSource.camera);
                printLog("Camera result $result");
                if (result != null && result.path.toString().validString) {
                  controller.imagePath.value = result.path.toString();
                }
              },
              title: "Capture Camera Image",
              minimumSize: const Size(0, 40),
              alignment: Alignment.center,
            ),
            MyButton(
              onPressed: () async {
                // var result = await Get.toNamed(galleryScreen);
                final XFile? result = await controller.picker
                    .pickImage(source: ImageSource.gallery);
                printLog("Gallery result $result");
                if (result != null && result.path.toString().validString) {
                  controller.imagePath.value = result.path.toString();
                }
              },
              title: "Upload Gallery Image",
              minimumSize: const Size(0, 40),
              alignment: Alignment.center,
            ),
            // Center(child: myHelper.getAssetImage('app_icon')),
          ],
        ),
      ),
    );
  }
}
