package com.eserdeiro.common_impls

import NativeCardAd
import NativeCardGoogleAD
import NativeTileAd
import android.view.LayoutInflater
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

    // Obtener el LayoutInflater desde el contexto
    val layoutInflater = LayoutInflater.from(flutterPluginBinding.applicationContext)

    // Registrar las fábricas de anuncios aquí
    GoogleNativeAdManager.registerAdFactory("card-ad", NativeCardAd(layoutInflater))
    GoogleNativeAdManager.registerAdFactory("card-ad-google", NativeCardGoogleAD(layoutInflater))
    GoogleNativeAdManager.registerAdFactory("tile-ad", NativeTileAd(layoutInflater))
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

    // Desregistrar las fábricas de anuncios aquí
    GoogleNativeAdManager.unregisterAdFactory("card-ad")
    GoogleNativeAdManager.unregisterAdFactory("tile-ad")
    GoogleNativeAdManager.unregisterAdFactory("card-ad-google")
  }
}
