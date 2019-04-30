package li.a1lo.docsearch.doc_search

import io.flutter.plugin.common.PluginRegistry

object VideoViewPlugin {
    fun registerWith(registrar: PluginRegistry.Registrar) {
        registrar
                .platformViewRegistry()
                .registerViewFactory(
                        "li.a1lo.docsearch.doc_search/videoview", VideoViewFactory(registrar.messenger()))
    }
}