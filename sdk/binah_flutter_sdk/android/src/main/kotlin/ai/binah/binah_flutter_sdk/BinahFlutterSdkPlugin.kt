package ai.binah.binah_flutter_sdk


import ai.binah.sdk.api.HealthMonitorException
import ai.binah.sdk.session.PolarSessionBuilder
import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


class BinahFlutterSdkPlugin: FlutterPlugin, ActivityAware, MethodCallHandler {

  private val methodChannelId = "plugins.binah.ai/flutter_plugin"
  private val eventChannelId = "plugins.binah.ai/sdk_events"
  private var methodChannel : MethodChannel? = null
  private var eventChannel : EventChannel? = null
  private lateinit var pluginBinding: FlutterPlugin.FlutterPluginBinding
  private lateinit var applicationContext: Context
  private var sessionManager: SessionManager? = null

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    pluginBinding = flutterPluginBinding
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    applicationContext = binding.activity
    pluginBinding.platformViewRegistry.registerViewFactory(BinahPreviewFactory.cameraPreviewId, BinahPreviewFactory)
    methodChannel = MethodChannel(pluginBinding.binaryMessenger, methodChannelId).also { channel ->
      channel.setMethodCallHandler(this)
    }

    eventChannel = EventChannel(pluginBinding.binaryMessenger, eventChannelId).also { channel ->
      sessionManager = SessionManager(BinahEventChannel(channel)).also { manager ->
        BinahPreviewFactory.setDataSource(manager)
      }
    }
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivity() {
    methodChannel?.setMethodCallHandler(null)
    eventChannel?.setStreamHandler(null)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    try {
      when (call.method) {
        NativeBridgeApi.createSession -> {
          sessionManager?.createCameraSession(
            applicationContext,
            call.argument<String>("licenseKey") ?: "",
            call.argument<String>("productId"),
            call.argument<Int>("measurementMode"),
            call.argument<Int>("deviceOrientation"),
            call.argument<Int>("subjectSex"),
            call.argument<Double>("subjectAge"),
            call.argument<Double>("subjectWeight"),
            call.argument<Boolean>("detectionAlwaysOn"),
            call.argument<Boolean>("strictMeasurementGuidance"),
            call.argument<Map<String, Any>>("options")
          )
          result.success(null)
        }
        NativeBridgeApi.createPPGDeviceSession -> {
          sessionManager?.createPPGDeviceSession(
            applicationContext,
            call.argument<String>("licenseKey") ?: "",
            call.argument<String>("productId"),
            call.argument<String>("deviceId") ?: "",
            call.argument<Int>("deviceType") ?: 0,
            call.argument<Int>("subjectSex"),
            call.argument<Double>("subjectAge"),
            call.argument<Double>("subjectWeight"),
            call.argument<Map<String, Any>>("options")
          )
          result.success(null)
        }
        NativeBridgeApi.startSession -> {
          sessionManager?.startSession(call.argument<Int>("duration"))
          result.success(null)
        }
        NativeBridgeApi.stopSession -> {
          sessionManager?.stopSession()
          result.success(null)
        }
        NativeBridgeApi.terminateSession -> {
          sessionManager?.terminateSession()
          result.success(null)
        }
        NativeBridgeApi.getSessionState -> {
          result.success(sessionManager?.getSessionState()?.ordinal)
        }
        NativeBridgeApi.getNativeSdkVersion -> {
          result.success(mapOf(
            Pair("version", ai.binah.sdk.BuildConfig.VERSION_NAME),
            Pair("build", ai.binah.sdk.BuildConfig.VERSION_CODE),
          ))
        }
        NativeBridgeApi.getMinPolarVersion -> {
          result.success(PolarSessionBuilder.POLAR_MIN_VERSION)
        }
        NativeBridgeApi.startPPGDevicesScan -> {
          sessionManager?.startPPGDevicesScan(
            applicationContext,
            call.argument<String>("scannerId") ?: "",
            call.argument<Int>("deviceType") ?: 0,
            call.argument<Int>("timeout")?.toLong(),
          )
          result.success(null)
        }
        NativeBridgeApi.stopPPGDeviceScan -> {
          sessionManager?.stopPPGDeviceScan(call.argument<String>("scannerId") ?: "")
          result.success(null)
        }
      }
    } catch (e: HealthMonitorException) {
      result.error(e.errorCode.toString(), e.domain, null)
    }
  }
}
