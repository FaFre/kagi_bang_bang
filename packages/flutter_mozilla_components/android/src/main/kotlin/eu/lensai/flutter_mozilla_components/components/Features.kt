package eu.lensai.flutter_mozilla_components.components

import eu.lensai.flutter_mozilla_components.feature.WebExtensionToolbarFeature
import eu.lensai.flutter_mozilla_components.pigeons.GeckoAddonEvents
import mozilla.components.browser.state.store.BrowserStore

class Features(
    private val store: BrowserStore,
    private val addonEvents: GeckoAddonEvents
) {
    val webExtensionToolbarFeature by lazy {
        WebExtensionToolbarFeature(
            store,
            addonEvents
        )
    }
}