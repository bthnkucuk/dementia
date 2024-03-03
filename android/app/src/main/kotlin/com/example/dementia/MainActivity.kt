package com.example.dementia

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.bloc_event_sender"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            sendFlutterToEvent(call)
        }
    }

    private fun sendFlutterToEvent(call: MethodCall) {
        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
                .invokeMethod(call.method, call.arguments)
    }
}
