package com.liquimoney

import android.app.Application
import com.moengage.core.LogLevel
import com.moengage.flutter.MoEInitializer
import com.moengage.core.MoEngage
import com.moengage.core.config.LogConfig
import com.moengage.core.config.NotificationConfig
import io.flutter.Log

class MyApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        try {
            val moEngage: MoEngage.Builder = MoEngage.Builder(this, "T2TNL64IKIHYAKA11E2DWJR9")
                //.configureLogs(LogConfig(LogLevel.VERBOSE, true))
                .configureNotificationMetaData(
                    NotificationConfig(
                        R.mipmap.ic_launcher,
                       -1,
                        android.R.color.white,
                        true,
                        true,
                        true
                    )
                )
            MoEInitializer.initialiseDefaultInstance(context = this, builder = moEngage)
        } catch (e: java.lang.Exception) {
            Log.e(
                "MoEngage Android SDK Error ", "Error initialising MoEngage", e
            )
        }

    }
}