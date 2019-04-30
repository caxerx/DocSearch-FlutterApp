package li.a1lo.docsearch.doc_search

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        VideoViewPlugin.registerWith(this.registrarFor("li.a1lo.docsearch.doc_search.VideoViewPlugin"))
    }
}
