package com.liquimoney

import android.content.ContentResolver
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.moengage.core.LogLevel
import com.moengage.core.internal.logger.Logger
import com.moengage.firebase.MoEFireBaseHelper
import com.moengage.pushbase.MoEPushHelper

class NotificationService : FirebaseMessagingService() {

    private val tag = "CustomNotificationService"

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        try {
            val pushPayload = remoteMessage.data
            if (MoEPushHelper.getInstance().isFromMoEngagePlatform(pushPayload)) {
                MoEFireBaseHelper.getInstance().passPushPayload(applicationContext, pushPayload)
            }
        } catch (e: Exception) {
            Logger.print(LogLevel.ERROR, e) { "$tag onMessageReceived() : " }
        }
    }

}