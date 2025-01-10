package com.liquimoney

import android.app.Activity
import android.content.*
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import com.google.android.gms.auth.api.phone.SmsRetriever
import com.google.android.gms.common.api.CommonStatusCodes
import com.google.android.gms.common.api.Status
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.lang.ref.WeakReference
import java.util.regex.Pattern

/**
 * OTPAutoFillPlugin
 */
class OTPAutoFillPlugin : FlutterPlugin, ActivityAware, MethodCallHandler {
    private var activity: Activity? = null
    private var channel: MethodChannel? = null
    private var broadcastReceiver: SmsBroadcastReceiver? = null

    constructor() {}

    constructor(registrar: Registrar) {
        activity = registrar.activity()
        setupChannel(registrar.messenger())
    }

    fun setCode(code: String?) {
        channel!!.invokeMethod("otpcode", code)
    }

    override fun onMethodCall(call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "listenForCode" -> {
                //if(Build.VERSION.SDK_INT > Build.VERSION_CODES.S_V2) return
                val smsCodeRegexPattern = call.argument<String>("smsCodeRegexPattern")
                val client = SmsRetriever.getClient(
                    activity!!
                )
                val task = client.startSmsRetriever()
                task.addOnSuccessListener {
                    unregisterReceiver() // unregister existing receiver
                    broadcastReceiver = SmsBroadcastReceiver(
                        WeakReference(this@OTPAutoFillPlugin),
                        smsCodeRegexPattern

                    )
                    if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                        activity!!.registerReceiver(
                            broadcastReceiver,
                            IntentFilter(SmsRetriever.SMS_RETRIEVED_ACTION),
                            Context.RECEIVER_EXPORTED
                        )
                    } else {
                        activity!!.registerReceiver(
                            broadcastReceiver,
                            IntentFilter(SmsRetriever.SMS_RETRIEVED_ACTION),
                        )
                    }

                    result.success(null)
                }
                task.addOnFailureListener {
                    result.error(
                        "ERROR_START_SMS_RETRIEVER",
                        it.message ?:"empty",
                        null
                    )
                }
            }
            "unregisterListener" -> {
                unregisterReceiver()
                result.success("successfully unregister receiver")
            }
            "getAppSignature" -> {
                val signatureHelper = AppSignatureHelper(
                    activity!!.applicationContext
                )
                val appSignature = signatureHelper.appSignature
                result.success(appSignature)
            }
            else -> result.notImplemented()
        }
    }

    private fun setupChannel(messenger: BinaryMessenger) {
        channel = MethodChannel(messenger, channelName)
        channel!!.setMethodCallHandler(this)
    }

    private fun unregisterReceiver() {
        if (broadcastReceiver != null) {
            try {
                activity!!.unregisterReceiver(broadcastReceiver)
            } catch (ex: Exception) {
                // silent catch to avoir crash if receiver is not registered
            }
            broadcastReceiver = null
        }
    }

    /**
     * This `FlutterPlugin` has been associated with a [FlutterEngine] instance.
     *
     *
     * Relevant resources that this `FlutterPlugin` may need are provided via the `binding`. The `binding` may be cached and referenced until [.onDetachedFromEngine]
     * is invoked and returns.
     */
    override fun onAttachedToEngine(@NonNull binding: FlutterPluginBinding) {
        setupChannel(binding.binaryMessenger)
    }

    /**
     * This `FlutterPlugin` has been removed from a [FlutterEngine] instance.
     *
     *
     * The `binding` passed to this method is the same instance that was passed in [ ][.onAttachedToEngine]. It is provided again in this method as a convenience. The `binding` may be referenced during the execution of this method, but it must not be cached or referenced after
     * this method returns.
     *
     *
     * `FlutterPlugin`s should release all resources in this method.
     */
    override fun onDetachedFromEngine(@NonNull binding: FlutterPluginBinding) {
        unregisterReceiver()
    }

    /**
     * This `ActivityAware` [FlutterPlugin] is now associated with an [Activity].
     *
     *
     * This method can be invoked in 1 of 2 situations:
     *
     *
     *  * This `ActivityAware` [FlutterPlugin] was
     * just added to a [FlutterEngine] that was already
     * connected to a running [Activity].
     *  * This `ActivityAware` [FlutterPlugin] was
     * already added to a [FlutterEngine] and that [       ] was just connected to an [       ].
     *
     *
     *
     * The given [ActivityPluginBinding] contains [Activity]-related
     * references that an `ActivityAware` [ ] may require, such as a reference to the
     * actual [Activity] in question. The [ActivityPluginBinding] may be
     * referenced until either [.onDetachedFromActivityForConfigChanges] or [ ][.onDetachedFromActivity] is invoked. At the conclusion of either of those methods, the
     * binding is no longer valid. Clear any references to the binding or its resources, and do not
     * invoke any further methods on the binding or its resources.
     */
    override fun onAttachedToActivity(@NonNull binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    /**
     * The [Activity] that was attached and made available in [.onAttachedToActivity]
     * has been detached from this `ActivityAware`'s [FlutterEngine] for the purpose of processing a
     * configuration change.
     *
     *
     * By the end of this method, the [Activity] that was made available in
     * [.onAttachedToActivity] is no longer valid. Any references to the associated [ ] or [ActivityPluginBinding] should be cleared.
     *
     *
     * This method should be quickly followed by [ ][.onReattachedToActivityForConfigChanges], which signifies that a new [Activity] has
     * been created with the new configuration options. That method provides a new [ActivityPluginBinding], which
     * references the newly created and associated [Activity].
     *
     *
     * Any `Lifecycle` listeners that were registered in [ ][.onAttachedToActivity] should be deregistered here to avoid a possible memory leak and
     * other side effects.
     */
    override fun onDetachedFromActivityForConfigChanges() {
        unregisterReceiver()
    }

    /**
     * This plugin and its [FlutterEngine] have been re-attached to an [Activity] after the [Activity]
     * was recreated to handle configuration changes.
     *
     *
     * `binding` includes a reference to the new instance of the [ ]. `binding` and its references may be cached and used from now until either [ ][.onDetachedFromActivityForConfigChanges] or [.onDetachedFromActivity] is invoked. At the conclusion of
     * either of those methods, the binding is no longer valid. Clear any references to the binding or its resources,
     * and do not invoke any further methods on the binding or its resources.
     */
    override fun onReattachedToActivityForConfigChanges(@NonNull binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    /**
     * This plugin has been detached from an [Activity].
     *
     *
     * Detachment can occur for a number of reasons.
     *
     *
     *  * The app is no longer visible and the [Activity] instance has been
     * destroyed.
     *  * The [FlutterEngine] that this plugin is connected to
     * has been detached from its [FlutterView].
     *  * This `ActivityAware` plugin has been removed from its [       ].
     *
     *
     *
     * By the end of this method, the [Activity] that was made available in [ ][.onAttachedToActivity] is no longer valid. Any references to the
     * associated [Activity] or [ActivityPluginBinding] should be cleared.
     *
     *
     * Any `Lifecycle` listeners that were registered in [ ][.onAttachedToActivity] or [ ][.onReattachedToActivityForConfigChanges] should be deregistered here to
     * avoid a possible memory leak and other side effects.
     */
    override fun onDetachedFromActivity() {
        unregisterReceiver()
    }

    private class SmsBroadcastReceiver(
        val plugin: WeakReference<OTPAutoFillPlugin?>,
        val smsCodeRegexPattern: String?
    ) :
        BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            if (SmsRetriever.SMS_RETRIEVED_ACTION == intent.action) {
                if (plugin.get() == null) {
                    return
                } else {
                    plugin.get()!!.activity!!.unregisterReceiver(this)
                }
                val extras = intent.extras
                val status: Status?
                if (extras != null) {
                    status = extras[SmsRetriever.EXTRA_STATUS] as Status?
                    if (status != null) {
                        if (status.statusCode == CommonStatusCodes.SUCCESS) {
                            // Get SMS message contents
                            val message = extras[SmsRetriever.EXTRA_SMS_MESSAGE] as String?
                            val pattern = Pattern.compile(
                                smsCodeRegexPattern
                            )
                            if (message != null) {
                                val matcher = pattern.matcher(message)
                                if (matcher.find()) {
                                    plugin.get()!!.setCode(matcher.group(0))
                                } else {
                                    plugin.get()!!.setCode(message)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    companion object {
        private const val channelName = "otp_autofill"

        /**
         * Plugin registration.
         */
        fun registerWith(registrar: Registrar) {
            OTPAutoFillPlugin(registrar)
        }
    }
}