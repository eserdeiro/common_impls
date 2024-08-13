package com.eserdeiro.common_impls

import com.wortise.ads.flutter.natives.GoogleNativeAdManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** CommonImplsPlugin */
class CommonImplsPlugin : FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "common_impls")
    channel.setMethodCallHandler(this)
    // Register ad factories here
    GoogleNativeAdManager.registerAdFactory(
            "card-ad",
            NativeCardAd(flutterPluginBinding.applicationContext.layoutInflater)
    )
    GoogleNativeAdManager.registerAdFactory(
            "card-ad-google",
            NativeCardGoogleAD(flutterPluginBinding.applicationContext.layoutInflater)
    )
    GoogleNativeAdManager.registerAdFactory(
            "tile-ad",
            NativeTileAd(flutterPluginBinding.applicationContext.layoutInflater)
    )
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    // Unregister ad factories here
    GoogleNativeAdManager.unregisterAdFactory("card-ad")
    GoogleNativeAdManager.unregisterAdFactory("tile-ad")
    GoogleNativeAdManager.unregisterAdFactory("card-ad-google")
  }
}
