package eu.lensai.flutter_mozilla_components.api

import eu.lensai.flutter_mozilla_components.GlobalComponents
import eu.lensai.flutter_mozilla_components.pigeons.GeckoEngineSettingsApi
import mozilla.components.concept.engine.Engine
import mozilla.components.feature.addons.logger

/**
 * Implementation of GeckoEngineSettingsApi that manages engine-specific settings
 */
class GeckoEngineSettingsApiImpl : GeckoEngineSettingsApi {
    companion object {
        private const val TAG = "GeckoEngineSettingsApi"
    }

    private val components by lazy {
        requireNotNull(GlobalComponents.components) { "Components not initialized" }
    }

    override fun javaScriptEnabled(state: Boolean) {
        try {
            components.core.engine.settings.javascriptEnabled = state
            logger.debug("$TAG: JavaScript enabled state changed to: $state")
        } catch (e: Exception) {
            logger.error("$TAG: Failed to set JavaScript enabled state", e)
            throw IllegalStateException("Failed to set JavaScript enabled state", e)
        }
    }
}
