package com.example.flutter_app2

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES


/**
*  用于从flutter调用Android原生的平台api，遇到几个坑需要解决：
 *  1.flutter Unresolved reference: android
 *  需要删除 。idea文件夹，然后先打开flutter目录下的Android目录，再重新打开flutter目录
 *  这种方法虽然会解决报错问题，但是也会让其他的报错无法显示出来
 *
 *  2.Flutter Android ERROR: ensureInitializationComplete must be called after startInitialization
 *  需要将io.flutter.app.FlutterActivity替换成io.flutter.embedding.android.FlutterActivity 和 io.flutter.embedding.engine.FlutterEngine
 *  flutterView -》flutterEngine?.getDartExecutor()
 *
 *  3.Only safe (?.) or non-null asserted (!!.) calls are allowed on a nullable receiver of type FlutterEngine?
 *  . -》 ?.
**/
class MainActivity() : FlutterActivity() {
    private val CHANNEL = "samples.flutter.io/battery"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        //GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterEngine?.getDartExecutor(), CHANNEL)?.setMethodCallHandler { call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }
}