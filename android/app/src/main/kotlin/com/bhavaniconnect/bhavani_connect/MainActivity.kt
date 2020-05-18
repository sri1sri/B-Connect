package com.bhavaniconnect.bhavani_connect

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService

class MainActivity : FlutterActivity(), PluginRegistry.PluginRegistrantCallback {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
//        flutterEngine.plugins.add(FirebaseMessagingPlugin());
    }

    override fun registerWith(registry: PluginRegistry) {
//        FirebaseCloudMessagingPluginRegistrant.registerWith(registry)
    }

}
