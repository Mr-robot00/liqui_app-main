package com.liquimoney

import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity() {

    override fun onStart() {
        super.onStart()
        try {
            flutterEngine?.plugins?.add(OTPAutoFillPlugin())
        } catch (e: java.lang.Exception) {
            Log.e(
                "GeneratedPluginRegistrant",
                "Error registering plugin otp_autofill, com.liquimoney.OTPAutoFillPlugin",
                e
            )
        }
        try {
            flutterEngine?.plugins?.add(DeviceUniqueId())
        } catch (e: java.lang.Exception) {
            Log.e(
                "GeneratedPluginRegistrant",
                "Error registering plugin DeviceUniqueId, com.liquimoney.DeviceUniqueId",
                e
            )
        }
    }
}
